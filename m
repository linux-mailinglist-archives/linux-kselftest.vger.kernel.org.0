Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1446C47C72D
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Dec 2021 20:07:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241680AbhLUTHM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 21 Dec 2021 14:07:12 -0500
Received: from mail-mw2nam10on2046.outbound.protection.outlook.com ([40.107.94.46]:20276
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232879AbhLUTHL (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 21 Dec 2021 14:07:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NEtKZcrEsv0GKk5p5CnTYo6rfh3AY2tMoWJ58F54EY7xnPOJ3/LBb/bDg8LyVDoe97OPJapcHBkR/GOsSPRwgRtEBAkBwSpc8vo7rrnPz7uSBvQ7siTujV6MXTEw1hsxIF476bgOmSwwRv6LiE3UbCZuFeXJeFaJN9KbvejPu2WCpdqi7viZwYDbLE4CLIHsVqdN+1Bfy/VCoAcRLlBGf5kfdgeLPhkj/oZU4d6B33z6ZngHR2JRAeZb6f1cpH8BrqwWya+Z+eSMVLLz4LhC9J3x9RDq8aBjmRtowCbOnAFvdr6cAhENlA79lfNKQTPP6Pd2DmJGimtLkQ+0p3GcRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fFjsZL748uBTPNS/Uc1kPhz7m4378xHoBnX/B63PK+s=;
 b=bTQ5pKA6AY1Eseke7NqmX/Yy5HRYVlwAmeMKdpYTlaV/UjoRoYCRjkD/a9Y4BGrZ+LgeZoUpB5FqrLlrzOMmfQPgRO6LSxcmyZ24CyWMNLUXMe5eYfkrv0UuyesnxONAuQacq1ET/oSBR//BreWNiQtKbVv7PPB1+AjQ+IX3z/3SXiq74DHT9oH8TqQyCS3Ud08mwWo7Ic9YF84kYFDD33H1/lzKAYbZN0Dxpapt00kV7MilZYcJWJMt7Hh0aGtAJK0ORP2Wz1Bd/+7DUp33wTvPfPryky6xCbJBtaFqFtMJ92ephpzoLXM9HGTwcMWaIczO/8vlOoDRkT0WDTO7zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fFjsZL748uBTPNS/Uc1kPhz7m4378xHoBnX/B63PK+s=;
 b=V1ScowuKaM6UTdqO8Kcw7Je+RI+lfAi55sPR2u23qUPPpk9g1POXKO4SiHq+WpLtqdhVA/Svxn4mVRH6YHf2KPqU1746z43HgxPsjuOikAIBZCAhlhBnqq8CIqBt5Q5D9AZRHigwbh12kDVSYTgPm3NRgxxvJPmHvVkCfRaz6RdSn0HbLFvJmNJpatbZNkUXuh00QFwK18VK9cpxKBJB752oizxa1eDT/PvlCgwmw0luhfrnbjbRNl+hXAJO+UM2pX31+5NffG3C+aWBMv+nvmpCrmjC4hr2C77j4L57aYPSNRaFmPAa7IhcB+RSQQWbmCf+w7eYY1WK6imOEKdP0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5176.namprd12.prod.outlook.com (2603:10b6:208:311::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.15; Tue, 21 Dec
 2021 19:07:08 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11%7]) with mapi id 15.20.4823.017; Tue, 21 Dec 2021
 19:07:08 +0000
Date:   Tue, 21 Dec 2021 15:07:06 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
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
Message-ID: <20211221190706.GG1432915@nvidia.com>
References: <4D97206A-3B32-4818-9980-8F24BC57E289@vmware.com>
 <CAHk-=whxvVQReBqZeaV41=sAWfT4xTfn6sMSWDfkHKVS3zX85w@mail.gmail.com>
 <5A7D771C-FF95-465E-95F6-CD249FE28381@vmware.com>
 <CAHk-=wgMuSkumYxeaaxbKFoAbw_gjYo1eRXXSFcBHzNG2xauTA@mail.gmail.com>
 <CAHk-=whYT0Q1F=bxG0yi=LN5gXY64zBwefsbkLoRiP5p598d5A@mail.gmail.com>
 <fca16906-8e7d-5d04-6990-dfa8392bad8b@redhat.com>
 <20211221010312.GC1432915@nvidia.com>
 <fd7e3195-4f36-3804-1793-d453d5bd3e9f@redhat.com>
 <CAHk-=wgQq3H6wfkW7+MmduVgBOqHeiXQN97yCMd+m1mM-1xCLQ@mail.gmail.com>
 <900b7d4a-a5dc-5c7b-a374-c4a8cc149232@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <900b7d4a-a5dc-5c7b-a374-c4a8cc149232@redhat.com>
X-ClientProxiedBy: YT1PR01CA0070.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::9) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 199ffdb1-d13a-4d33-2024-08d9c4b51590
X-MS-TrafficTypeDiagnostic: BL1PR12MB5176:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB517601F2F1839A77F84AB93AC27C9@BL1PR12MB5176.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +XjfN9pRO7nq/p9LuETHFGY7G5iwAwR//EEWNWXS24vszRVy3zJPqrHbLB/RxrH7VKyRL9SrOP0IlFTsIeTdKt40SkV2qgvr1d5SoNStrmzyq+Rkdic6JMILHKItnZa2JUEX5Fk+mnZv2WgHB9wa3qBA+/5HPRZASbpcpjNfiQuzg0KmkAvyCm7L4o4/SVaI5wZ46mc7JRxW7aAV+A2uejURb0Z4JntCNMo8GfKmDccZpwCBS08I/lPzEgYD3O1nJ9ykKu2HQBwgCEGfs1x+7u462v0EbSpmABGVr33PFPQwNU/dUnz/BwRlwjmYztFodX2CO1nUnGk5qTP9rZ7cNgmgc0JS/PB7r6e4BvO+xkIv3tDQYYMx3vHpzNMM17IYShbJhYBORt0Rp/bSFyOtutKqXTw9lxSxlMl0HOaUV2QXATKgK18E+/80RpAPWhGZkZQZMTK8fZSi/pVZ3hs25k6SxEZWLMtXkVEb6z8Y2TtvK2mUv0fFv+i7e3maxsMQ0UEZ+eWiBmOc4rbm+MQWGFMGAhXG/YoWIBYb5m/Vpw0jrMmpUqSAf3Touqs4bwJH/a7WkW9gdwRA+5vTjEBc0XQk+We1FIKlqMBcIvbruyGzTMtwBNx+atAr58FZXPdbWRD/xuR1yBcYZ0xME0B8WQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(1076003)(7416002)(66476007)(8936002)(26005)(83380400001)(6506007)(54906003)(4744005)(66556008)(66946007)(36756003)(86362001)(2616005)(33656002)(6512007)(5660300002)(6916009)(6486002)(316002)(186003)(4326008)(2906002)(508600001)(38100700002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VXiYsqO1Gy++oDzuFW6Htnfe2Z0/jgJpfrAPl7NnnrZnigIy1gRVG4HmKZuX?=
 =?us-ascii?Q?Mlg+L1gsIcrblBPBt+cc415fM9/yYub4WXmZmMINfziaSntaC2sLI/OB1Vov?=
 =?us-ascii?Q?CUKsJTUHCxilDSQasuJhoOBIGdGgKb5ha3Mu60VO0Hw1WtDBS4rcVzJYsuB/?=
 =?us-ascii?Q?Ca7PNeekObaYTPPtI7hYxhgKuWNXVfeYGJreaSvx8S7z3LgZ3Z1GaIawQ2c7?=
 =?us-ascii?Q?5QB9Y6i12LPUQdNfZX6Yq1ptoQp0HAsBTtfhXqKivnbjCl6XCJWTnAg5dWbN?=
 =?us-ascii?Q?7cX8v3aWZsEssYIeDrrE3nCCvh8gpFCzGO8kSOu12iDMIlxJsBmNTQ9p52Qz?=
 =?us-ascii?Q?fEkerqNSBmql0StwbNL/alI09tg33UAVmFj9siI7iJsFny1LuacvdD1ItN+u?=
 =?us-ascii?Q?QTwl3eWimz9I2xvqIpjRYeMbkK5NLyipAyORrIeCqXAronE7xLaYRSs661Fc?=
 =?us-ascii?Q?XH6ZSCRGKuCpBut7aPy/V+CGwf5/NuZGR6UQtwv93uaJLal+mgLqUTA29KhD?=
 =?us-ascii?Q?Ehj/OWf/YsXXONIskngDetbyrom8u5WTqYVjTS7GtZWMK9EBGTHDdV2f7ECa?=
 =?us-ascii?Q?B1ytxk640EPNRlf10irRYGfDQxCaZmBMdufsHzs1Rz861aevWLT7hKU7J6KX?=
 =?us-ascii?Q?vkBnfG5HWJ4x168Dc2SDjpOW3JwouijUYwCt3Wae1eScHcCjDpB0p/fvdKP8?=
 =?us-ascii?Q?36mz88/mLIWMdtY9HyCTemTEGNKHN+p7iJ4A9/txiabr7/4nFJvpLP5TZnyb?=
 =?us-ascii?Q?x5LpSJBTZ6jxHW823B3ezqVH3ES0mz8L/e5l41dG7sA5z17BDk8tMQ2IydLV?=
 =?us-ascii?Q?wBrVzYH1rBj/hsGxeUwA29KF/IkGWgp79ltf6OgcWlv/UFVRG2cGadAdRmjx?=
 =?us-ascii?Q?gFNScBnFpmRtQy5iq02XtKJB6JxmnEVsFHsXWVz1j/0ERFLA2nPyRGj9HPws?=
 =?us-ascii?Q?5P0ToL9yZ8Fx8qk2SzQtFcTx4jhKQiAewHE015vySjh5pFIikC9PfXTTAdeR?=
 =?us-ascii?Q?pRRpXp5lEdK5LuWbwH/ifpO6lDAIO7yO4npKVDHXJ4NGFoIRJxGmDkRBXPI5?=
 =?us-ascii?Q?Bz9P5nDA40ZS8YRi9AT3qOh+SY2LCl1E7gGta6JctXgT0p1RiqxkOduqgwkS?=
 =?us-ascii?Q?SK6CsuuntOWXUZ8x2XIrToFEjBZw/67JcGwq42ps1uL4QBsAl8KZiZWe7eLW?=
 =?us-ascii?Q?60k582NHmyBDejLR3QCO8mP6A9zZw0k/sKqdFM8uRGjs90kwSYhdKvASTKs2?=
 =?us-ascii?Q?ewl1zK/qmKlqko4N9AS2i+KmM3mPa2iSsg8m60X48VHT+RBmapaFZR6P8W2b?=
 =?us-ascii?Q?p5WcRBh0GTvUAO4oilhdmHeePBsCFOMmLXCM7DjOUpzcH03ALi8HtihiHbA4?=
 =?us-ascii?Q?zmu3FvEoP++MN8SnyGe8WknZCC+o3i0R5V3TCNE6kKpaF1ldWxrT5AtzNYuS?=
 =?us-ascii?Q?SLlyRM2ZptQhBHvnpGCukgUFJQ0Bh4gjo43TNJzlyhaVP2mDOjWrwo6PfuWy?=
 =?us-ascii?Q?hmG5Wq+nkHHLxcFT18HfpCCsACYLztI3HJp9qSnTnIWfWD+oYxF+Z4WDPWQN?=
 =?us-ascii?Q?jG28yQjMBoYWyPX1rsM=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 199ffdb1-d13a-4d33-2024-08d9c4b51590
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2021 19:07:08.1726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v4LbJZsYnZtxh2RwIo5+gKZBfkPEz1rsVpfgyL5DVQAOndRnyM01qBLXpU0aLH1L
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5176
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Dec 21, 2021 at 06:40:30PM +0100, David Hildenbrand wrote:

> 2) is certainly the cherry on top. But it just means that R/O pins don't
> have to be the weird kid. And yes, achieving 2) would require
> FAULT_FLAG_EXCLUSIVE / FAULT_FLAG_UNSHARED, but it would really 99% do
> what existing COW logic does, just bypass the "map writable" and
> "trigger write fault" semantics.

I still don't agree with this - when you come to patches can you have
this work at the end and under a good cover letter? Maybe it will make
more sense then.

Thanks,
Jason
