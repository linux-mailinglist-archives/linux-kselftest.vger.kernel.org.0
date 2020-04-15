Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57CBC1AB1B7
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Apr 2020 21:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437917AbgDOTaC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Apr 2020 15:30:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:55134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437842AbgDOT37 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Apr 2020 15:29:59 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF1C520774;
        Wed, 15 Apr 2020 19:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586978998;
        bh=HcxMWDYswwSk16CJXI7QG7JgXa8lgyRgaEpGjU1zGT0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=18LdT+B4dO4XKOdbgBT1rE8jARtHpNmRaiCUmOgAu7rk7jVGCFxtr+tTfUMqwFGMb
         ZwOKmWfXgpuNviXjE3qZRnMwSGRgYlnHg58T1M11d7ZNU+5XtsnBJ2aZm+ICz2SDNL
         E2mRQsg8FYQQ6dpMXrqfeg6ciZ+MBeHYlRos5IFY=
Date:   Wed, 15 Apr 2020 22:29:52 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Ralph Campbell <rcampbell@nvidia.com>
Cc:     Jason Gunthorpe <jgg@mellanox.com>,
        Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, linux-rdma@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v8 0/3] mm/hmm/test: add self tests for HMM
Message-ID: <20200415192952.GA1309273@unreal>
References: <20200321003108.22941-1-rcampbell@nvidia.com>
 <20200415144125.GU11945@mellanox.com>
 <6d7adb28-96a0-5dc5-e85e-68fca2db403a@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d7adb28-96a0-5dc5-e85e-68fca2db403a@nvidia.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Apr 15, 2020 at 10:28:23AM -0700, Ralph Campbell wrote:
>
> On 4/15/20 7:41 AM, Jason Gunthorpe wrote:
> > On Fri, Mar 20, 2020 at 05:31:05PM -0700, Ralph Campbell wrote:
> > > This series adds basic self tests for HMM and are intended for Jason
> > > Gunthorpe's rdma tree which has a number of HMM patches applied.
> >
> > Here are some hunks I noticed while testing this:
> >
> > --- a/lib/Kconfig.debug
> > +++ b/lib/Kconfig.debug
> > @@ -2201,7 +2201,8 @@ config TEST_MEMINIT
> >   config TEST_HMM
> >   	tristate "Test HMM (Heterogeneous Memory Management)"
> > -	depends on DEVICE_PRIVATE
> > +	depends on TRANSPARENT_HUGEPAGE
> > +	select DEVICE_PRIVATE
> >   	select HMM_MIRROR
> >   	select MMU_NOTIFIER
> >   	help
> >
> > It fails testing if TRANSPARENT_HUGEPAGE is not on
> >
> > @@ -1097,6 +1071,7 @@ static int dmirror_device_init(struct dmirror_device *mdevice, int id)
> >   	spin_lock_init(&mdevice->lock);
> >   	cdev_init(&mdevice->cdevice, &dmirror_fops);
> > +	mdevice->cdevice.owner = THIS_MODULE;
> >   	ret = cdev_add(&mdevice->cdevice, dev, 1);
> >   	if (ret)
> >   		return ret;
> >
> > The use of cdev without a struct device is super weird, but it still
> > needs this
> >
> > diff --git a/tools/testing/selftests/vm/test_hmm.sh b/tools/testing/selftests/vm/test_hmm.sh
> > index 461e4a99a362cf..0647b525a62564 100755
> > --- a/tools/testing/selftests/vm/test_hmm.sh
> > +++ b/tools/testing/selftests/vm/test_hmm.sh
> > @@ -59,7 +59,7 @@ run_smoke()
> >   	echo "Running smoke test. Note, this test provides basic coverage."
> >   	load_driver
> > -	./hmm-tests
> > +	$(dirname "${BASH_SOURCE[0]}")/hmm-tests
> >   	unload_driver
> >   }
> >
> > Make it runnably reliably
> >
> > Jason
>
> Thanks for the fixes. I'll apply these and send a v9.
> I will also add missing calls to release_mem_region() to free the reserved device private
> addresses.

If you decide to ignore my request to avoid addition of special header
file to UAPI, at least don't copy and install that file without some
special CONFIG option (TEST_HMM ???) requested by the users. It also
will be good to get Acked-by on this change from HMM people.

However, I still think that include/uapi/linux/test_hmm.h opens
pandora box of having UAPI files without real promise to keep it
backward compatible.

Thanks

>
