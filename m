Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D821F2B3301
	for <lists+linux-kselftest@lfdr.de>; Sun, 15 Nov 2020 09:46:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbgKOIph (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 15 Nov 2020 03:45:37 -0500
Received: from verein.lst.de ([213.95.11.211]:51528 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726647AbgKOIp0 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 15 Nov 2020 03:45:26 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1416767373; Sun, 15 Nov 2020 09:45:16 +0100 (CET)
Date:   Sun, 15 Nov 2020 09:45:15 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        Linuxarm <linuxarm@huawei.com>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "xuwei (O)" <xuwei5@huawei.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH v3 1/2] dma-mapping: add benchmark support for
 streaming DMA APIs
Message-ID: <20201115084515.GA18411@lst.de>
References: <20201102080646.2180-1-song.bao.hua@hisilicon.com> <20201102080646.2180-2-song.bao.hua@hisilicon.com> <20201114165336.GA24844@lst.de> <5c4488dd28fc4869b7e67dd842ffa208@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c4488dd28fc4869b7e67dd842ffa208@hisilicon.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Nov 15, 2020 at 12:11:15AM +0000, Song Bao Hua (Barry Song) wrote:
> 
> Checkpatch has changed 80 to 100. That's probably why my local checkpatch didn't report any warning:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=bdc48fa11e46f867ea4d
> 
> I am happy to change them to be less than 80 if you like.

Don't rely on checkpath, is is broken.  Look at the codingstyle document.

> > I think this needs to set a dma mask as behavior for unlimited dma
> > mask vs the default 32-bit one can be very different. 
> 
> I actually prefer users bind real devices with real dma_mask to test rather than force to change
> the dma_mask in this benchmark.

The mask is set by the driver, not the device.  So you need to set when
when you bind, real device or not.
