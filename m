Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81464203DD0
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jun 2020 19:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729777AbgFVRZd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 22 Jun 2020 13:25:33 -0400
Received: from mail-am6eur05on2069.outbound.protection.outlook.com ([40.107.22.69]:28225
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729605AbgFVRZc (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 22 Jun 2020 13:25:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BidjBoC05sbSiqzs+vPodYnpohx+pSlgRVmf+4Xk8WdsCrmjCJwSPqyb7Lnmp4oyNU87a1StokNt/K/uvbcz/ICfXOjPFH1Q1K1SU8xOycweUjiyRlsgYaBsCq30NkrS6rcMls79ICPoH3wXKtkIlLdwaEcg9JtsDy6bmil6gT5ExTQlwAjqHZ4eFy99L64r5qTN2jN1YjAbNYUW8VvsejYPVXLKc+Vvr2Z1rcVG88UqgEH1xrlpM0BAv54WULypHLvR8BeEfgrWHLdGDNrwzVJanZZVzsZtUdJFskHa3K7F4k4VB83twCO6YKOy2GC8LA9gwX+D1AXdOMhrFJ5e6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IJNzHWIAGB/ZM5J6dWwHzLGD/KdUAdGK9R9F2lPT4dM=;
 b=XsOTkFV8CFkkZ6XK25FMTszw9wkEzMT7ix9BzdupgXGyILoyRObpp3kZPxbCRLCKkTzBBRYA1ZuhJFIJg5yEg4/zvNgl45BGiJlifgf4MuPdkAqxsdt5o09McZfIouko3vXLapYdxkXs9MmkX8KrUmir3B6RNT9s5+laMdGVgUjREOc6DExqGMQzopdbn2/hohV/o7qU87F/9iMP8/hwW4Ozh/nSizcqxDAZ4TUG8QURGi14V5VYIXw1bNzZgB6NHnzbywwcmk/I0eRQIfV4EhKX31c0KA0lFbMGu/N2xWZQSOKe1AY4go2IncascO0aFveOtSCQO0emumj0WPYgmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IJNzHWIAGB/ZM5J6dWwHzLGD/KdUAdGK9R9F2lPT4dM=;
 b=AHreMLCPbnm4ixyjorZujudym73z9zFa5t6fKdx8eNyUn8VcEr5xGZIFOoirvKtOC/lJ0zgLf25SituELBPSG+HUpjrCcv0X8FDiakxXuQzN9xm+LlsCq1DykUJ+LKiVxDO9OpqvFyPqo+SlCr5Q7rgWKpJbUVbbKgLZaFzRwXs=
Authentication-Results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=mellanox.com;
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (2603:10a6:803:44::15)
 by VI1PR05MB5840.eurprd05.prod.outlook.com (2603:10a6:803:d4::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.21; Mon, 22 Jun
 2020 17:25:28 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::848b:fcd0:efe3:189e]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::848b:fcd0:efe3:189e%7]) with mapi id 15.20.3109.027; Mon, 22 Jun 2020
 17:25:28 +0000
Date:   Mon, 22 Jun 2020 14:25:20 -0300
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
Message-ID: <20200622172520.GB2874652@mellanox.com>
References: <20200619215649.32297-1-rcampbell@nvidia.com>
 <20200619215649.32297-10-rcampbell@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200619215649.32297-10-rcampbell@nvidia.com>
X-ClientProxiedBy: MN2PR15CA0041.namprd15.prod.outlook.com
 (2603:10b6:208:237::10) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (193.47.165.251) by MN2PR15CA0041.namprd15.prod.outlook.com (2603:10b6:208:237::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22 via Frontend Transport; Mon, 22 Jun 2020 17:25:27 +0000
Received: from jgg by mlx with local (Exim 4.93)        (envelope-from <jgg@mellanox.com>)      id 1jnQC8-00C3wZ-8l; Mon, 22 Jun 2020 14:25:20 -0300
X-Originating-IP: [193.47.165.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3134e947-9a82-4c8f-04e2-08d816d14191
X-MS-TrafficTypeDiagnostic: VI1PR05MB5840:
X-Microsoft-Antispam-PRVS: <VI1PR05MB58402F157DC5E574D8756A7CCF970@VI1PR05MB5840.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0442E569BC
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KURyjSz4ScoQ2r1vTkfJwETpG2699tok/nQPEwqwao8SWGZiNF4RtVi8/ZgorLCxaYzGLDeTJ5rEUpl+sp6vv5iXSNXO9CiHkuNq5bYSzRW3nWinjmNBEV/zydM4B87kEDPCiN6YlgyWIXOFAtRJan6DwCP3a2sIf5SXQh/xUK6aFi5ny/lWJbkp0gabgf4PcO+pO1Yp0TP2rXhOG2OikuLDJxPvJlZ4RrVeU+AWyqxRD76Yag9dYFAz0H0OvInOBXZbZA8JqyWrWWlQMqN4H8JR2lGqcbzEir49a7xxisc8Rcgw8lsNNbmFSM7OXD1JulQugMtzPUfzT8KjKtTqGg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR05MB4141.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(396003)(366004)(39860400002)(346002)(136003)(426003)(316002)(66946007)(7416002)(2616005)(26005)(83380400001)(8676002)(6916009)(9786002)(9746002)(8936002)(4326008)(86362001)(478600001)(5660300002)(186003)(66476007)(66556008)(1076003)(54906003)(36756003)(33656002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: auwP/K2/suirbaFq/+Ec6A/S1e43ilx2TcfbDnbBeAEtPfNtefX9/cNPSOno22Mkoj8bkS4OJJAN6+zdPyfFiYFgrZIlb7Q7wwKHZBm9QDsMe7fy4/dCOOzap4wi/229u/cmtSVzMlbIoTvlbKCUdZVvEYifWY2MQ2Ehl7S5QEsRJ7ZKTaUM+IVv/seJeXsGHA6d8ndoIKThlVH0yoDGgwJtIFW1yd5boShyBZBCfCSLhFr0J7XwFPQPbb228fXL5/pQ291V9kIKo0hHYb0DT1NFNGafdTohbL/L9+mgvtQGmfHvkjITOcav/h9j4OzmgAheLsjiZla7QZ6IFU9lbcmtocFZl+0nqjxliivOz66iygs7BVKhGnA+UTwGOWDDpeCicjS1NaXsHPsSktqK2hI4JDLqOoTmaSJc2Cl5wMygul6nNlT19IQRhspzN4CUVr4C3zlaD5qjA1w/ec5z3NYma5gwyA1N9m4Sguf2HQHj9tPgZOpt/bEjL2asx5ye
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3134e947-9a82-4c8f-04e2-08d816d14191
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2020 17:25:28.5349
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XLaqU3Mz045KbGCunZn5Pp17GrFk3RaX8kCi9hJjR6Q0SroMn75wv8FcER3sciLPxo60baC6tHNHmyPmwpIMNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5840
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jun 19, 2020 at 02:56:42PM -0700, Ralph Campbell wrote:
> hmm_range_fault() returns an array of page frame numbers and flags for
> how the pages are mapped in the requested process' page tables. The PFN
> can be used to get the struct page with hmm_pfn_to_page() and the page size
> order can be determined with compound_order(page) but if the page is larger
> than order 0 (PAGE_SIZE), there is no indication that the page is mapped
> using a larger page size. To be fully general, hmm_range_fault() would need
> to return the mapping size to handle cases like a 1GB compound page being
> mapped with 2MB PMD entries. However, the most common case is the mapping
> size is the same as the underlying compound page size.
> Add a new output flag to indicate this so that callers know it is safe to
> use a large device page table mapping if one is available.

But what size should the caller use?

You already explained that the caller cannot use compound_ordet() to
get the size, so what should it be?

Probably this needs to be two flags, PUD and PMD, and the caller should
use the PUD and PMD sizes to figure out how big it is?

Jason
