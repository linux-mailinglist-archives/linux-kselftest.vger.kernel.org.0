Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0952AB352
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Nov 2020 10:14:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729805AbgKIJOX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 9 Nov 2020 04:14:23 -0500
Received: from verein.lst.de ([213.95.11.211]:57688 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727920AbgKIJOW (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 9 Nov 2020 04:14:22 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id BBE6E68B05; Mon,  9 Nov 2020 10:14:20 +0100 (CET)
Date:   Mon, 9 Nov 2020 10:14:15 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Ralph Campbell <rcampbell@nvidia.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-mm@kvack.org,
        nouveau@lists.freedesktop.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Alistair Popple <apopple@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Bharata B Rao <bharata@linux.ibm.com>,
        Zi Yan <ziy@nvidia.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Ben Skeggs <bskeggs@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 3/6] mm: support THP migration to device private
 memory
Message-ID: <20201109091415.GC28918@lst.de>
References: <20201106005147.20113-1-rcampbell@nvidia.com> <20201106005147.20113-4-rcampbell@nvidia.com> <20201106080322.GE31341@lst.de> <a7b8b90c-09b7-2009-0784-908b61f61ef2@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7b8b90c-09b7-2009-0784-908b61f61ef2@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Nov 06, 2020 at 01:26:50PM -0800, Ralph Campbell wrote:
>
> On 11/6/20 12:03 AM, Christoph Hellwig wrote:
>> I hate the extra pin count magic here.  IMHO we really need to finish
>> off the series to get rid of the extra references on the ZONE_DEVICE
>> pages first.
>
> First, thanks for the review comments.
>
> I don't like the extra refcount either, that is why I tried to fix that up
> before resending this series. However, you didn't like me just fixing the
> refcount only for device private pages and I don't know the dax/pmem code
> and peer-to-peer PCIe uses of ZONE_DEVICE pages well enough to say how
> long it will take me to fix all the use cases.
> So I wanted to make progress on the THP migration code in the mean time.

I think P2P is pretty trivial, given that ZONE_DEVICE pages are used like
a normal memory allocator.  DAX is the interesting case, any specific
help that you need with that?
