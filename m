Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D242C203DC1
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jun 2020 19:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729918AbgFVRWq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 22 Jun 2020 13:22:46 -0400
Received: from mail-am6eur05on2087.outbound.protection.outlook.com ([40.107.22.87]:14048
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729777AbgFVRWq (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 22 Jun 2020 13:22:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b32HDAZmwsH/NLWCZc/Zk6bNZargd3hU2zPWGcLBWCGRvPYZkOIan7/fnJx1rHLL+QNTooNq0swR54m9+zevU450gphPknF4v0CvvJou0sG75G6KVAjV+cj8o5oBlU8c8o8zBaEczoBH3LflZqsKqELwyqGm1+tED23zOBwvvfEWm43fYTLtxeLUJqw+wdPid5sPRhYi/YkRVqZf+M9yqdC7w/K/LJj66/koS1bAlsAtooCi4n5AhxoAANZqZoCn9UmgZBWTvftf2BqpYsY7StDR9qCAqS6Dfp/3iFGHFnr9RpRZzrenZuCLWeldzmMZOyRFTQTCe3nzUpDMuAGtsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZKectm0+qs0cuBJgP3c2OnTQLlbCMRvDxj3UBNyQf/U=;
 b=nljlTZAxM0J/LpRw+Ft+9xwR/7mL1E17IULqimWDAJauOUSbpJoZKKKWkAzdUSxkwlcLyCZXQ+4+hd1vrYRy1W2LIepkPqMuKQ9kalXJxSNx29/AqkFoLGx1ewyUptdC2+gDi3iJUgXynI9s1Y1/yb6Y1/n4MNIJwq8t7ajyKJDsVAUXxy0ZVBMmu6onuMrdzFQ/K6JJ5MVygyt9de8V1efXeBAGCXNdkMhEB8TG/AeVQGxQn1AHEsq/VMQhZbn/S4NtfxWOVnv6QmLKCasxbvVrAfX18OfgSOeBP67GFFp5/MNnoUWf6LdpOCbvs+s0GgPJQH9lCfeAqqbpcfB2jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZKectm0+qs0cuBJgP3c2OnTQLlbCMRvDxj3UBNyQf/U=;
 b=KcZNn7vrUQ/BTAeCGx2kR4KEOqZSxIBX/VgfX6MiQy27+TcKoruyyptu2AXlinm04N3FKkGqP7Re99hbf+aAJ/FarJURJMyvVhbDiyeVz2zbldGXstBDZ+hvuyOUe8IOQCC0gLK0eG99sidAq2MqXkOpDsDTTnwbz88xZfbREB4=
Authentication-Results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=mellanox.com;
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (2603:10a6:803:44::15)
 by VI1PR05MB6494.eurprd05.prod.outlook.com (2603:10a6:803:100::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Mon, 22 Jun
 2020 17:22:41 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::848b:fcd0:efe3:189e]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::848b:fcd0:efe3:189e%7]) with mapi id 15.20.3109.027; Mon, 22 Jun 2020
 17:22:41 +0000
Date:   Mon, 22 Jun 2020 14:22:33 -0300
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
Subject: Re: [PATCH 08/16] nouveau/hmm: fault one page at a time
Message-ID: <20200622172233.GA2874652@mellanox.com>
References: <20200619215649.32297-1-rcampbell@nvidia.com>
 <20200619215649.32297-9-rcampbell@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200619215649.32297-9-rcampbell@nvidia.com>
X-ClientProxiedBy: BL0PR02CA0015.namprd02.prod.outlook.com
 (2603:10b6:207:3c::28) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (193.47.165.251) by BL0PR02CA0015.namprd02.prod.outlook.com (2603:10b6:207:3c::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22 via Frontend Transport; Mon, 22 Jun 2020 17:22:41 +0000
Received: from jgg by mlx with local (Exim 4.93)        (envelope-from <jgg@mellanox.com>)      id 1jnQ9R-00C3sG-M6; Mon, 22 Jun 2020 14:22:33 -0300
X-Originating-IP: [193.47.165.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5b2c37c8-af36-454b-70db-08d816d0de49
X-MS-TrafficTypeDiagnostic: VI1PR05MB6494:
X-Microsoft-Antispam-PRVS: <VI1PR05MB6494E2ABEC536D22A63FCAD5CF970@VI1PR05MB6494.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-Forefront-PRVS: 0442E569BC
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IXvycNDMc5RMGwlYeJ+YnrJ2D7KgM9glamVnejhokPj9xPAbBRcQ3M89m9TBZsQ7rHDPqrs04awCLTPLHLCZSb6PhUL02Czkfi4pMMPhQSsqM858WUuAnaCe6Wz0eoBGuPea15JTPk+A4eYTY9b9oKlm2KGUe+XRB+ymDulbsQUSb++UVAsYL9bBtumX2CfpxyBtBPk8CITWIHtULrPamyK3Poy3uX0cZ7zWgQF7X9T5n7rm4TqW7Mm+YSOvOeqTOUEP3xl1+9AmbATV/11zuVK+Px33RfL2WZfbMK9XyDfI5f9GYrQszHzEaij1bZkoMGcZspyu/6WFx6Wsvc4MLA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR05MB4141.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(396003)(346002)(366004)(376002)(136003)(6916009)(2906002)(8676002)(83380400001)(4744005)(478600001)(5660300002)(1076003)(7416002)(26005)(66946007)(66556008)(66476007)(54906003)(186003)(316002)(33656002)(36756003)(4326008)(86362001)(2616005)(8936002)(426003)(9746002)(9786002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: gvDYLvKbgVwEl33Rn7X5Vj0i9U+FbAJvJ83QtIxWJBG7X4MHCyaGvmiPtUKNxlzNQ+2kNjZ5bkZuuDUvhiqjayML65bWjCxDZWC7feFyxhE2WOa+iPnFTcsjghcPnh2lHYxd8fz5zeZMQrmbASfV+D37O4OBd6pXUseJyxspg3C6Xn+UZnd2sOwc3J7mC7qXSLo9pnbEZBEulJK/YEwqp852mvnXSFnl3HOWTqb3CR2wC8Kf49WrB9WoTWbYF0U5hv6d/BSvf3GEJPsf7sWAXOYjGCHwfuKWc2GuGnvh1N33YfmJD7T23FCAC23r8L5vhh3+ZFJkesHI4NMpDoGFX9RZyP5TiYQhaSSYyNHpkzg6ozlp0v1MYuDbmJr0r/b7uF+/yh+DZcanDg3OtzgrUnVS0KmcL/72vebQU4GSa8BbxAONkDPiTdihFEUm8N3tdwJvDIcXkH80UZHF9XIq1TpKAbLDBlp1ZwmF9cAnENQOrXnzjla7jtOPg4jGR/5S
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b2c37c8-af36-454b-70db-08d816d0de49
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2020 17:22:41.4756
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ksDzDYTK5UipZwivhJaLjYXw3npL9JnP4FtxxXu4Hc8+RTV4sV2D4QgcPk9P592aaA+WDWxMbSxQ43IZnRJQ9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6494
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jun 19, 2020 at 02:56:41PM -0700, Ralph Campbell wrote:
> The SVM page fault handler groups faults into a range of contiguous
> virtual addresses and requests hmm_range_fault() to populate and
> return the page frame number of system memory mapped by the CPU.
> In preparation for supporting large pages to be mapped by the GPU,
> process faults one page at a time. In addition, use the hmm_range
> default_flags to fix a corner case where the input hmm_pfns array
> is not reinitialized after hmm_range_fault() returns -EBUSY and must
> be called again.

Are you sure? hmm_range_fault is pretty expensive per call..

Jason
