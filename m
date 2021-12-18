Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91FDB4797E7
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Dec 2021 01:50:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbhLRAud (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Dec 2021 19:50:33 -0500
Received: from mail-bn8nam11on2088.outbound.protection.outlook.com ([40.107.236.88]:27105
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231367AbhLRAuc (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Dec 2021 19:50:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DXdPTse/dgp/8GiMNzi+IAnD1mHk0i42obTdiAd7hJjTxOjwiiqt2vLhRIe94OFoJaLtf4WjTB+XNqhSWalt4MlyLo/dDeSTfYFwTHQCwpEzG9if/Bcr+1oXe52E9cyIjAdTtTCOMmsWy4NKoOyfiU6YwrVLnoMEDg3U5/+CNZzmvIXRH5SjyIY4F/HzQ7uKIj3zMQNpbs+V/b3HRfPm2EWYgliY1gR13Vx5V3K6JhhWFRCSKGpxVuAUgdIBMXsNOUcnm2h6lVE0B4EGZi8aunmRVDusDh95ZI0sNS4GkfF8OISX5t2u8boyRn2px+G+BK9298V0/cEQ10hJlrpOfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+phq2UJa14TuN6+SS37sBZj7HVSVx0FotHNikOs0OEg=;
 b=fe6oq2sUaxQct5FKp7Ee+7fv7HnYkXYbrTmhGLXqjmoKxo8HYpk3u2uipLkxeluouXg4L4kD7zn6DJT74ca0p+B4xTFBkvxewu7JD8C3VYI5GETaJTOENN6kjKD2VKxDVpuG2oRsNjzIppBd0cl5HpRiqodaGiFitEoA1uRCq4rGtcYFKs3vpQN86yVAWTMfqMkxmZe5hH4arZKzsZORSuPR1mDR1nsLtIRiqYuDyVMaRHIc4nAto8uX5KGv5mbBORoOdExY2TIP093o/3970U4SkT+rWnRzYVSW+gyXLVAb5Y1TeBbKO8Cs7YEAPZcEwVKKRzlJ0d0G6H1B5E4elQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+phq2UJa14TuN6+SS37sBZj7HVSVx0FotHNikOs0OEg=;
 b=j3N5giXj8RVRTK6cn8KxeWdl850oNCz991Zuwzxl4g2fCN5R2Jit2ROWAbrK8Zl3MulyIhhjZvaXpBCihTf9ALkrJKMyLm9ceayjnKRrv2z0NTMYzPVSNVG56FAlkmuKQqHWuOhf1HzZSsP8odJ5HC11sNDxIFzlTlBPQNByfIq0Wl9kvTtgTAe4fG/NXBR4CSbUu3+S9fjeJxQ3OYyrzXDDn0gJmqD9QMwVK9lS7+VhnpM4seENrJyAwUBjXzGA0JZNmWxpzthW8Q0n5NTw4yZ7rOyNiRpItjVrgu9dzljXuov+dsYVNBjzlYFxg1Hi3MH5W29VlLapIo+Kp77a0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5206.namprd12.prod.outlook.com (2603:10b6:208:31c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Sat, 18 Dec
 2021 00:50:30 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11%8]) with mapi id 15.20.4801.017; Sat, 18 Dec 2021
 00:50:30 +0000
Date:   Fri, 17 Dec 2021 20:50:29 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
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
Message-ID: <20211218005029.GG6385@nvidia.com>
References: <20211217113049.23850-1-david@redhat.com>
 <20211217113049.23850-7-david@redhat.com>
 <CAHk-=wgL5u3XMgfUN6BOqVO0OvPx3-LEri1ju-1TW4dFhHQO4g@mail.gmail.com>
 <CAHk-=wgKft6E_EeLA1GnEXcQBA9vu8m2B-M-U7PuiNa0+9gpHA@mail.gmail.com>
 <54c492d7-ddcd-dcd0-7209-efb2847adf7c@redhat.com>
 <CAHk-=wgjOsHAXttQa=csLG10Cp2hh8Dk8CnNC3_WDpBpTzBESQ@mail.gmail.com>
 <20211217204705.GF6385@nvidia.com>
 <37dddd67-7e2d-8217-b1e2-31d79bb85693@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37dddd67-7e2d-8217-b1e2-31d79bb85693@redhat.com>
X-ClientProxiedBy: BLAPR03CA0047.namprd03.prod.outlook.com
 (2603:10b6:208:32d::22) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6d99bc81-4c37-4de9-ae18-08d9c1c063d1
X-MS-TrafficTypeDiagnostic: BL1PR12MB5206:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB5206079DCA43F15AFD086C5AC2799@BL1PR12MB5206.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7/0VLTjYF7VgD1zPzILAFNBT9U+hN9UiEHPHJFQq2g/K7HgO72RV5Z35/X48YZUqUetAySGuI1p6aDgt3VBabUapleN+FotXY+wObeA+fZ+sz7iJy1VC2I5kHLWGM3o7qjdTZa9e5XxObSTPpptO0rNi7p75eJ+S4hg+ncyDetrRV6oC2Im9WlJYmgnxcAIZWiw2iCuH+EU6V4aIQwYIReoeamYZf4UAbx0VucWwo+QxxXA3g/NPcJ5XR7wWyZt5g8As/vU2F0vUnhB+5bldknt95ASWdqwP3VFcAVYC28p2bxhxmfCRfSefKi7HcMmoue5H/52LJXam25chsNyhk95AgNrDEfdzSAciKws9imlaSocSNs0rKrHmtfokfZyLghlzSg5GhxAWi1uyZ3603zcjKmBvcvIbEjle9It0XTSTUqluffTQyjo7v3zAgBjIOHH8QpUowlT9Tw9tRsACFE11FQwV4/e/jx18UXQTpUEDedEPvqoXAsyduGX0wHKer1ZRNb+wYZMBUfaZcj7DlyGwcLTivLefKszbROAPCDdYgD1VZfQZh1Z8303tUvTzngi8dujhRoYREHT19/kCCPB8vz19+CJahLORgOw2kEntU7Jw9PuSmXBH+lGgxP6bkBUc9UA1WjlB138NfCDBwwxKAE1K0kmuT6l+kCpOUUprt7lzPRnTOt9ZFVLRLhkEZyczRgwhWZ+xjVMj2yfdHg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(66476007)(86362001)(2906002)(508600001)(8936002)(7416002)(6916009)(38100700002)(54906003)(316002)(1076003)(83380400001)(36756003)(33656002)(66556008)(66946007)(186003)(26005)(6512007)(6506007)(4326008)(5660300002)(2616005)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lSZ0AomWEWCHKmrU8Dxuzasz93v4pq+UDzn+NbMZ8g2Rcv78qn14bYbj/ht9?=
 =?us-ascii?Q?0nCmGShdl5ApyomvGTXQmOXGplLS/2ZoqIaAeB1cZmShOTRidTWgJYKWk9Jy?=
 =?us-ascii?Q?98fg2rrV4Uek4M2p3UCmnSbIJlHIrh4mZ18oPgVgJNwVM+CxHi4E1LyTAgXX?=
 =?us-ascii?Q?rDMQ+UnDY4ku74w8Ndor1ZS5OWJ1gPUCQtOZDJYI8B8iqsBFv+LX+FossRio?=
 =?us-ascii?Q?n7J2X79yiYH+AmuBkxVM2PcBV/+VsdPoFNpLL8CBiTbf5BYwWIISmc7f55PB?=
 =?us-ascii?Q?BR/hJ/2Ar0ZfZ0UAbj5q3jEHfZ/Uir29YchKN4R3q7UHWPWzf7jdCdQ6CfpJ?=
 =?us-ascii?Q?hdKO6XySZuxiKdWdFgA2yc65b0LiPzUzBfpV5k2NIRd9qDmMuviiSlGffIqY?=
 =?us-ascii?Q?wyMKfpQS2+E00tHUvGsUS5+yNZCWPSmZegU5mUpEuiJR4FuSSNuaL6iWqHNs?=
 =?us-ascii?Q?Wl/DgbOZ5bc5D5a9e9PC7NKi4gJf9d9KhcZu7G4G8YvhaAFNFQ6PEEvdg1NW?=
 =?us-ascii?Q?wu696sV0QLl5zK7jEOk4ihGbxcf0jNOpekcV1Pp78Ul0lbWD0xjDxBG4OTeV?=
 =?us-ascii?Q?drwnHsCY6h0yZfsSnEjnTw66BTyO32CzD4fqhwkwVSp6s/l8KpTlFgnJX0lh?=
 =?us-ascii?Q?qRoer7xMIp7zOJnR7fb2suXqG07qAHsVLWoIDSOASWy4qAJh8P+mfBz0O9sH?=
 =?us-ascii?Q?oCd601068h/Nh0tUzrzizXd+FYtDAUx0mAQAruWUBdIbEAUE6NK473a9/WP4?=
 =?us-ascii?Q?vSzvGr5OJfQ055YDCjWfAv9Q0dNd2QMlx00IL1rWiw5RuGizQjbgTk94kvJN?=
 =?us-ascii?Q?n1gXrBRlKHNyUFS03FAbx9JeplEZHoUZO45s5xq8vRS+mMrYnhqL1PF4H9b4?=
 =?us-ascii?Q?70RcA6qHrpJZHpKquVcyuQm7M+HdGWB8j09pdFjIM0nyHr0Y/53KNuw6jNn1?=
 =?us-ascii?Q?Aaa49VppcwRrRuu6Fu1etndInB/M4juX9/ZzwtHP/V6yop4mJBeyD9ctCZkx?=
 =?us-ascii?Q?S6haOh6h4U8SpWgKxNlwlQTQtbDNjQrccwDm7oMUuJMPcfWTuPVk9W3Mb4qw?=
 =?us-ascii?Q?//TAChdEwyCSrP5YixSkRfjXdhO1L6+CZ7MzPBQNcc8YAT2nlD+zNQNlge1Q?=
 =?us-ascii?Q?FyLU+Hg+Jt5t2BCG0n0wjXalmn3UN5YQ/XjkEgS6thiG+mh12pkigYOJPUxU?=
 =?us-ascii?Q?EnAtKeTFocINvgwPIXGcOXBKcLnZKVKFYJ9uFD911WzfuiHOfxsLzHf4viIX?=
 =?us-ascii?Q?Nnn+BupzmLoIy+vjp9L5GQFW6HglMzn0FAm1QATUK0uQPoCpccDVBakWWt39?=
 =?us-ascii?Q?DYfpwLAaIpPC/74LziRRCJ9tSluUsQ+yrUBcof6c9c7/R1guAmVxsS+KHU1m?=
 =?us-ascii?Q?pFYZhdq1dx6cYmfIaLL+ytKqmVbDWc2gmocJlnPsZ+pvj8Oo/KpnawaaIchZ?=
 =?us-ascii?Q?ZO8CZPP80XTU/FV4+EoQ6CQqEXLmDoUC4+eDZJynpxeinDv1GpMOWR42nVcC?=
 =?us-ascii?Q?vp/ue43IkyBf/GWfbM20FDGQ+gFsOBVf/PbtaOe4oTa282TfXtAmmS1sPF9z?=
 =?us-ascii?Q?QOfRzsVxYDdH0uMPywk=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d99bc81-4c37-4de9-ae18-08d9c1c063d1
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2021 00:50:30.3921
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /y5OMCAzSND2ZqiCkmdKu61pmQWycYsE2VzT9tstNUBjfp57CGdppGP8aRGz0h/B
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5206
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Dec 17, 2021 at 10:04:11PM +0100, David Hildenbrand wrote:

> > To remind all, the GUP users, like RDMA, VFIO use
> > FOLL_FORCE|FOLL_WRITE to get a 'r/o pin' specifically because of the
> 
> I heard that statement often. Can you point me at the code?
> 
> VFIO: drivers/vfio/vfio_iommu_type1.c
> 
> vaddr_get_pfns() will end up doing a 
> pin_user_pages_remote(FOLL_LONGTERM) without 
> FOLL_FORCE|FOLL_WRITE.

> Is that added automatically internally?

No, it is just that VFIO is broken in this regard. AFAIK VFIO users
rarely use the read-only mode and haven't noticed this bug yet.

You can search for FOLL_FORCE and see the drivers that do it this way:

drivers/misc/habanalabs/common/memory.c:                                 FOLL_FORCE | FOLL_WRITE | FOLL_LONGTERM,
drivers/infiniband/core/umem.c:         gup_flags |= FOLL_FORCE;
drivers/media/v4l2-core/videobuf-dma-sg.c:      unsigned int flags = FOLL_FORCE;
drivers/media/common/videobuf2/frame_vector.c:                            FOLL_FORCE | FOLL_WRITE | FOLL_LONGTERM,

[etc]

No doubt there are others that do it right and wrong, this is badly
documented and misunderstood.

> But this series really just wants to fix the security issue as "part 1".
> Without any more breakages.

Sure, I'm just trying to understand why this example was brought up.

Jason
