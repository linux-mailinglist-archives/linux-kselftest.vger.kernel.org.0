Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C12D2C2892
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Nov 2020 14:45:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388568AbgKXNpI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 Nov 2020 08:45:08 -0500
Received: from verein.lst.de ([213.95.11.211]:54543 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387705AbgKXNpE (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 Nov 2020 08:45:04 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8EFEC6736F; Tue, 24 Nov 2020 14:45:02 +0100 (CET)
Date:   Tue, 24 Nov 2020 14:45:01 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Barry Song <song.bao.hua@hisilicon.com>
Cc:     iommu@lists.linux-foundation.org, hch@lst.de, robin.murphy@arm.com,
        m.szyprowski@samsung.com, linuxarm@huawei.com,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 0/2] dma-mapping: provide a benchmark for streaming
 DMA mapping
Message-ID: <20201124134501.GB31576@lst.de>
References: <20201116060848.1848-1-song.bao.hua@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201116060848.1848-1-song.bao.hua@hisilicon.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Thanks,

applied to the dma-mapping tree with two trivial cleanups to
map_benchmark_ioctl().
