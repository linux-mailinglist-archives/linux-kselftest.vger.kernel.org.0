Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AFBA1D5CAF
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 May 2020 01:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726374AbgEOXPs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 15 May 2020 19:15:48 -0400
Received: from mail-eopbgr140053.outbound.protection.outlook.com ([40.107.14.53]:19244
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726183AbgEOXPr (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 15 May 2020 19:15:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SK9akejPruwS71Xm4vL+UT2ifJbP5Os6AJZP9LMw//D2rQMR8nPuNx7KiZQSMKgk6KLK3l3tR+cz+ucJiYh+57h56tDCTzNN9CpynV4N8nLHBNKsXUujHc2bE5XIvhJ3JNISJh4KNuJZBQqfEYi+YDsennuOHv5inVupkEjviT6yYhWKE4o8jLTyfbEjTdGuvuiKuyZCGSeuzhn0zd3FRjY+YDem7AYK50LwM2XElCZYvrRSl4zM07Ih37+jKLr7/mWgP+b834p8harcgkpsBGCXz1xPiY9kvb3nAEFxyEC7HLmxNQx48UZ4CteoxGxkvIN1T0I9wRtzNQScAwT0RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rR+gLqBvIT3+9zxGdtXTiqYrmB+NehR+aYGhMkHESOk=;
 b=fpBPf3BsbZ1uBIq9B+y7v6R5GCtz6MuVogwXW/EzcY1mweCtIQlJ/2yGGCU0BeiML7ZMwFnwOZooEoX0Yvgze64C845EnIkdJA+7I2fWdBDVBHj1UgQIm9rYI2S6PDSv/6mhJOFQ0bVGLxXmIDAtz0vF3jWBvtJsPnvb43VJLAswqQzsmm54hECGgZX1A+CCb/hAcd40XegLGryKRE81rtuvdk1IwzhGqCgx5Sdijlv3NSnXwTBtX8mS5I3Hx2Z+bD/lSBwlD71wvryOuP0CQVtX+NCYQ2WHv8T9NA8btj/4PURO3DxTwSkNcoG4sgDwSGzGKUvnEDcBfDZN7OtePg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rR+gLqBvIT3+9zxGdtXTiqYrmB+NehR+aYGhMkHESOk=;
 b=QH28/sC8RC1bAVLHEyR33xmeutRBselzHqrEZzYc5wFSCbtpIUn6sAdpNLDnsOtFVDMnrMPKVQIRkRXRBGuqlWQR3c2YQ2btfqLDeDW7aidwtTb/J6pGLm3MQOEVkFHQoLBrSCSpQlJ4xbnaOo9H9QSOR5fi6IvSwFG+PqsZ37s=
Authentication-Results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=mellanox.com;
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (2603:10a6:803:44::15)
 by VI1PR05MB5982.eurprd05.prod.outlook.com (2603:10a6:803:e4::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.27; Fri, 15 May
 2020 23:15:43 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::848b:fcd0:efe3:189e]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::848b:fcd0:efe3:189e%7]) with mapi id 15.20.3000.022; Fri, 15 May 2020
 23:15:42 +0000
Date:   Fri, 15 May 2020 20:15:38 -0300
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Ralph Campbell <rcampbell@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH] mm/hmm/test: destroy xa_array instead of looping
Message-ID: <20200515231538.GD24561@mellanox.com>
References: <20200513214507.30592-1-rcampbell@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513214507.30592-1-rcampbell@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MN2PR07CA0021.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::31) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR07CA0021.namprd07.prod.outlook.com (2603:10b6:208:1a0::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.26 via Frontend Transport; Fri, 15 May 2020 23:15:42 +0000
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)     (envelope-from <jgg@mellanox.com>)      id 1jZjYI-0001vI-OI; Fri, 15 May 2020 20:15:38 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 011a953f-e07f-4830-c823-08d7f925e378
X-MS-TrafficTypeDiagnostic: VI1PR05MB5982:
X-Microsoft-Antispam-PRVS: <VI1PR05MB5982984A463DB7CBA89E644ACFBD0@VI1PR05MB5982.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 04041A2886
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /qooYkgnUqVRlS5VB9K7jNRyNqkJQ0bPX4BJgt/NB79FD4YSSnDjbIF5YxDSoi0hPptyAlMrudU5xC/ZjVIslzov5SBlVJaerYtRIwRuQ0yMpXlPcGlcC4OCR0uiijvl3cRo5wY53f4J4CgGuKgytVKfI9OCMqR6caQcEYLnbCIr6aSzTfBqYF1wqxpHv5X/t5fvrGOFxtvO9Oc+rECoGZFHrjEkdFIluD+7qKRjjSUyNn0Tm5CIESaIJYtSlmnRqjGddLmZZ4IwWfrTvAcYT99ow7VfB66gZG+MxrwWvswg12VgCl0YF5JGH3c1BNe2PRj1S/0Dmf4XQa7FlfYJROLNrTVxdcxVwetk+j7JNUCDsDANGrNiagoD58B5qOPthvZeoEf9k0BGK3nIRznU62TLk7gXNa4BMhcb4weW/N/MZYG0yD2rdaYYcMbqGGApOAH3iv7mO6EGr+fJGhtyZheSU24mUifJKUfhOAgWjA0UkAAU4fVrGG91iN1wCjlN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR05MB4141.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(39860400002)(346002)(396003)(376002)(366004)(5660300002)(7416002)(478600001)(36756003)(33656002)(4326008)(2616005)(316002)(9746002)(9786002)(8676002)(54906003)(52116002)(86362001)(8936002)(66476007)(66946007)(66556008)(6916009)(186003)(26005)(2906002)(1076003)(24400500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: LovFComTvo+EQ0YIeu1gYzMhBPNU+w4Y417w4fXl/bvEPfeGp5mcZqXa1E7ypuXyPHrw29XbuzvuXwSwCiBYWxXCr8dR1XDhWooDB5O0GDCjmobNA8JAmSqETI/+hZb5LwzVJjq3zIlX3cJtYqlZjNzR4jHVFnUrjOYpQh8c7tJXOkNE4CPwx8gM6bFdEZHW9JvuP7aSZj/aVOGD2U3Fh28SNBigGYi5ycwJfhg0jnoBf1XRbYRyDzzT0fo2xAHUXRNTAfg5URgXTieSv30wQgmmFn/Ffn97Mu7v5mNg4pfsTo6hdQj+bMEawpFku+9i9nmQpmi1Qp8w+q6nYp5+WbObksxBg7CVaErgJftiPcyo8HHwosH0qcZrd7kUI/JlJSiUfrDj5lmPv7EDYDeXArTTFZGGgY/vSu1HADq/+TlNdiRuc2trGYQUo1jCWo9f7N7CsZKAo5VZOVol3eXefisBnrXXsunSEC+e0GemmNY=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 011a953f-e07f-4830-c823-08d7f925e378
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2020 23:15:42.7540
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HQLQ9f5msyGRwirlCO2ep2bRj0FXGcJX2tF5gGgGDSHZ2S3EtvbV8D3zP4D6D4I4FYJ91RNRO8nuh12tu+11vQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5982
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, May 13, 2020 at 02:45:07PM -0700, Ralph Campbell wrote:
> The test driver uses an xa_array to store virtual to physical address
> translations for a simulated hardware device. The MMU notifier
> invalidation callback is used to keep the table consistent with the CPU
> page table and is frequently called only for a page or two. However, if
> the test process exits unexpectedly or is killed, the range can be
> [0..ULONG_MAX] in which case calling xa_erase() for every possible PFN
> results in CPU timeouts. Munmap() can result in a large range being
> invalidated but in that case, the xa_array is likely to contain entries
> that need to be invalidated.
> Check for [0..ULONG_MAX] explicitly and just destroy the whole table.
> 
> Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
> 
> This patch is based on Jason Gunthorpe's hmm tree and should be folded
> into the ("mm/hmm/test: add selftest driver for HMM") patch once this
> patch is reviewed, etc.
> 
>  lib/test_hmm.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/lib/test_hmm.c b/lib/test_hmm.c
> index 8b36c26b717b..b89852ec3c29 100644
> +++ b/lib/test_hmm.c
> @@ -201,7 +201,13 @@ static void dmirror_do_update(struct dmirror *dmirror, unsigned long start,
>  	 * The XArray doesn't hold references to pages since it relies on
>  	 * the mmu notifier to clear page pointers when they become stale.
>  	 * Therefore, it is OK to just clear the entry.
> +	 * However, if the entire address space is being invalidated, it
> +	 * takes too long to clear them one at a time so destroy the array.
>  	 */
> +	if (start == 0 && end == ULONG_MAX) {
> +		xa_destroy(&dmirror->pt);
> +		return;
> +	}
>  	for (pfn = start >> PAGE_SHIFT; pfn < (end >> PAGE_SHIFT); pfn++)
>  		xa_erase(&dmirror->pt, pfn);
>  }

Just use xa_for_each_range() instead of the naive loop, it already
optimizes against membership and avoids the need for the xa_destroy
hack

Jason
