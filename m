Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D058D20FFFE
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 Jul 2020 00:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbgF3WVE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 Jun 2020 18:21:04 -0400
Received: from mail-vi1eur05on2084.outbound.protection.outlook.com ([40.107.21.84]:6189
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725862AbgF3WVE (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 Jun 2020 18:21:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PUPOi8HA4uH2wIA9Obf67MoXOwy0S4pwh98pXfS57iHBMVG0xFS6MvEoxgF41bBDiUA3EzptAYlTvve9ManfJACWgB3voHrRHDaUYbG+5yTBYofJWk7k/1X9ih4GEFuMGjxw+AIq+VQn2yn/e8ZoDDJyQvIj7gRx7NTfWNhrIFNOw/Pdf925M3sKeczp64h3bKdI7fIMnd5buTaQKgZGOy3Da6e9Wh+wWVgn7jPQIkOnvq/jJ+kDXBOj7AzUzHldxgPLLaCKy0gWzd58RghRiUo9s18lIdWtpG+DKIKbnS/Md+UEKDLDSVqmxHGaSfUD86W1cviqhWf7CL+oVuUEzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h19aVKLMrF8mIDl6zqjlQ03nnO8DtydeTZ1kI6xFEqc=;
 b=JW3hx00UfX8ftCoyfiurIVqtl8FC6D8T1L8bdT8oIis3HlUsGuFr+/0gXXDKO3SMTOaaR8sfbYyjjdu8BqVnEYdwNy9Tq/z5AUMOGeMdbyTHZ7CTJTqoe0MHgUQJM0A/Cc/ep6X9mn7MsrP/SKrb1+rU79c9NCwbG6aGeyZEBsaJfsllg9ypO6RdOr6HUM0eyyt91wIzZjQ8gabD1xODCW3BK9lPiTgmg3hrCu1bhf7ARWh15JSqQGxr16DXJJXxmCccozxAnPMOtoO3JMag0UiqNMr3lUQzaA69MbIIYZyDm0VCpgsj3MXlVep6km2WXrx+6is3CdSCONam7NrsQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h19aVKLMrF8mIDl6zqjlQ03nnO8DtydeTZ1kI6xFEqc=;
 b=R+qJeH328yfzKGRlxqq8QmLdoT8Ur8ShbCnnvayCLyIfjAkESMox2G8fakr8CICJCqCcwhHu5Zc1psuj3ToGRSNFhLXuQ3Gv6f3TOj2y9sg6eQCo/2RZJfALVpo/Uu8l/j99CSpe20LBDy29OiXOstd5ZulqYRvfP+ahhTXAEmA=
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=mellanox.com;
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (2603:10a6:803:44::15)
 by VI1PR05MB6141.eurprd05.prod.outlook.com (2603:10a6:803:e1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20; Tue, 30 Jun
 2020 22:21:00 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::848b:fcd0:efe3:189e]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::848b:fcd0:efe3:189e%7]) with mapi id 15.20.3131.028; Tue, 30 Jun 2020
 22:21:00 +0000
Date:   Tue, 30 Jun 2020 19:20:55 -0300
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Ralph Campbell <rcampbell@nvidia.com>, linux-rdma@vger.kernel.org,
        linux-mm@kvack.org, nouveau@lists.freedesktop.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Ben Skeggs <bskeggs@redhat.com>
Subject: Re: [PATCH v2 2/5] mm/hmm: add output flags for PMD/PUD page mapping
Message-ID: <20200630222055.GM23821@mellanox.com>
References: <20200630195737.8667-1-rcampbell@nvidia.com>
 <20200630195737.8667-3-rcampbell@nvidia.com>
 <20200630212343.GP25523@casper.infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200630212343.GP25523@casper.infradead.org>
X-ClientProxiedBy: YT1PR01CA0048.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::17) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by YT1PR01CA0048.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21 via Frontend Transport; Tue, 30 Jun 2020 22:21:00 +0000
Received: from jgg by mlx with local (Exim 4.93)        (envelope-from <jgg@mellanox.com>)      id 1jqOcZ-002AAp-AF; Tue, 30 Jun 2020 19:20:55 -0300
X-Originating-IP: [206.223.160.26]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0403b811-949e-4159-1ece-08d81d43de3e
X-MS-TrafficTypeDiagnostic: VI1PR05MB6141:
X-Microsoft-Antispam-PRVS: <VI1PR05MB61417ACAC68ADAF530AA96F4CF6F0@VI1PR05MB6141.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0450A714CB
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZQhvMnn9/OTkpSUWx5TRD+uSPQ4afdbuuqU3MmFvnkh0CNojV2ngQPT4ItpnYy4Wc288LCwavqgGIY3Iv2DKX+EjNsRs8di2qFsAQ1ExeexTlBQH2kUi/45ptwVh1GgEmQk1roF1Yxa+Sd2NNAHGOVr1bDx5zLX4wM85ZpptUQty56upVvePMF0x8A0VoYPh6XaQViU+jGTpeuNCuEklLFPbAsL/hlwIJs1BDPZCiZhS9OuwBwVEcb6h5JEiovy6ReyJ09MWWqx1HMdz/QDpYYY1ayWwp/dYCwuojLVZn8Pts4nJVnt8Fa87JcEpOhdCOscesPJt15Ga6JFbO0LMoQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR05MB4141.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(136003)(376002)(39860400002)(366004)(346002)(426003)(9746002)(2616005)(9786002)(8676002)(4326008)(186003)(83380400001)(8936002)(36756003)(316002)(33656002)(66946007)(66476007)(66556008)(6916009)(7416002)(1076003)(478600001)(5660300002)(54906003)(2906002)(26005)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: qsba+7FKT8L7SCEQkaOpztzVt89oIzyY1zm8VhgYBW8q6Gq1Z3LnXlj+Y0L0GL2bY7U5MoCb4xTxsp65HkQwJX39zIzOAnGBMYbFPRzDdmN3Lm5tsMGrOGPB6Vlp8kUVbtvciBLKHZQV0UE1eXnBlKslVxSlczGJDEfBmsRLucQf/5yk0QnJ6vyNiavN1gbrmET6b2nSvs1VxZYZG6PdPuoQAScZCuOlxvVQaPctIbyXmP7DS2UXYU2YNVBf3tP+yQVb+OG9zgv93TfpYfdOHq32sT/sIjlOD8S3Z4FpKSJWXJosUnoFanygF585K7qEg2G4Uob5/pyG0yxyxjcOXQk+Tdb2DurnhjI/2EDpdCj9sX/r2GnlZFagZ9mzsYjV5gxdaLOoth2wEZhJTV88DV4OalgBUuGD1d4R9jOyrq+n2WI/8LJoA8CoFKajBGrBd2L2+aHc/38UqwQWHia7Qx5y83o9Hk0lhpXXBA7tJ/DxlDpNdz4wTRtd9AwjAbh+
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0403b811-949e-4159-1ece-08d81d43de3e
X-MS-Exchange-CrossTenant-AuthSource: VI1PR05MB4141.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2020 22:21:00.3331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y3VaRAvapggBJGp3Zmw93BL1Whc2kCltnXZPSMtM/p+pSKrzm38pnyJi+sOvr6QRMh41h7YCcwbegBOHpGg2Ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6141
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jun 30, 2020 at 10:23:43PM +0100, Matthew Wilcox wrote:
> On Tue, Jun 30, 2020 at 12:57:34PM -0700, Ralph Campbell wrote:
> > hmm_range_fault() returns an array of page frame numbers and flags for
> > how the pages are mapped in the requested process' page tables. The PFN
> > can be used to get the struct page with hmm_pfn_to_page() and the page
> > size order can be determined with compound_order(page) but if the page
> > is larger than order 0 (PAGE_SIZE), there is no indication that a
> > compound page is mapped by the CPU using a larger page size. Without
> > this information, the caller can't safely use a large device PTE to map
> > the compound page because the CPU might be using smaller PTEs with
> > different read/write permissions.
> > 
> > Add two new output flags to indicate the mapping size (PMD or PUD sized)
> > so that callers know the pages are being mapped with consistent permissions
> > and a large device page table mapping can be used if one is available.
> 
> The problem I have with this is that PTE/PMD/PUD are not the only choices
> for how the CPU might choose to map something.  For example, ARM has
> the ability to map 64kB pages using 16 consecutive page table entries
> (marked specially so the CPU knows to use a single TLB entry for the
> 64kB range).  Some other CPUs have similar capabilities.

Sure, but at the moment this is the only thing hmm_range_fault() is able
to detect and set..

> I'd rather you encoded the order of the mapping in the flags (eg a
> number between 0 and 31) so that we have the flexibility in the future
> to describe how memory is mapped.

How about some hmm_get_mapping_order() API, we can keep the flags that
match the implementation but the driver facing API will see something
more general?

Jason
