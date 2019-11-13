Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C49CFFB1C2
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Nov 2019 14:51:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbfKMNvT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 13 Nov 2019 08:51:19 -0500
Received: from verein.lst.de ([213.95.11.211]:34361 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726957AbfKMNvS (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 13 Nov 2019 08:51:18 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 59C4068AFE; Wed, 13 Nov 2019 14:51:15 +0100 (CET)
Date:   Wed, 13 Nov 2019 14:51:15 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Ralph Campbell <rcampbell@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Shuah Khan <shuah@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v4 2/2] mm/hmm/test: add self tests for HMM
Message-ID: <20191113135115.GA10688@lst.de>
References: <20191104222141.5173-1-rcampbell@nvidia.com> <20191104222141.5173-3-rcampbell@nvidia.com> <20191112152521.GC12550@lst.de> <07589a71-3984-b2a6-b24b-6b9a23e1b60d@nvidia.com> <20191112234549.GX21728@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191112234549.GX21728@mellanox.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Nov 12, 2019 at 11:45:52PM +0000, Jason Gunthorpe wrote:
> > Well, it would mean registering for the whole process address space.
> > I'll give it a try.
> 
> I'm not sure it makes much sense that this testing is essentially
> modeled after nouveau's usage which is very strange compared to the
> other drivers.

Which means we really should make the test cases fit the proper usage.
Maybe defer the tests for 5.5 and just merge the first patch for now?
