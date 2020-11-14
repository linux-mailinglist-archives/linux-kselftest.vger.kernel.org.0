Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBE812B2EAE
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Nov 2020 17:54:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbgKNQxl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 14 Nov 2020 11:53:41 -0500
Received: from verein.lst.de ([213.95.11.211]:50595 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726603AbgKNQxk (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 14 Nov 2020 11:53:40 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id CD7B267373; Sat, 14 Nov 2020 17:53:36 +0100 (CET)
Date:   Sat, 14 Nov 2020 17:53:36 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Barry Song <song.bao.hua@hisilicon.com>
Cc:     iommu@lists.linux-foundation.org, hch@lst.de, robin.murphy@arm.com,
        m.szyprowski@samsung.com, linuxarm@huawei.com,
        linux-kselftest@vger.kernel.org, xuwei5@huawei.com,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH v3 1/2] dma-mapping: add benchmark support for
 streaming DMA APIs
Message-ID: <20201114165336.GA24844@lst.de>
References: <20201102080646.2180-1-song.bao.hua@hisilicon.com> <20201102080646.2180-2-song.bao.hua@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201102080646.2180-2-song.bao.hua@hisilicon.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Lots of > 80 char lines.  Please fix up the style.

I think this needs to set a dma mask as behavior for unlimited dma
mask vs the default 32-bit one can be very different.  I also think
you need to be able to pass the direction or have different tests
for directions.  bidirectional is not exactly heavily used and pays
more cache management penality.
