Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 389104D10D4
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Mar 2022 08:20:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236167AbiCHHVD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Mar 2022 02:21:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232229AbiCHHVD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Mar 2022 02:21:03 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF36A33A01
        for <linux-kselftest@vger.kernel.org>; Mon,  7 Mar 2022 23:20:07 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 05D0C68AFE; Tue,  8 Mar 2022 08:20:03 +0100 (CET)
Date:   Tue, 8 Mar 2022 08:20:02 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Tian Tao <tiantao6@hisilicon.com>
Cc:     song.bao.hua@hisilicon.com, hch@lst.de, shuah@kernel.org,
        chenxiang66@hisilicon.com, skhan@linuxfoundation.org,
        iommu@lists.linux-foundation.org, linux-kselftest@vger.kernel.org,
        linuxarm@openeuler.org
Subject: Re: [RESEND] dma-mapping: benchmark: Extract a common header file
 for map_benchmark definition
Message-ID: <20220308072002.GA24887@lst.de>
References: <20220308062857.45585-1-tiantao6@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220308062857.45585-1-tiantao6@hisilicon.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Mar 08, 2022 at 02:28:57PM +0800, Tian Tao wrote:
> kernel/dma/map_benchmark.c and selftests/dma/dma_map_benchmark.c
> have duplicate map_benchmark definitions, which tends to lead to
> inconsistent changes to map_benchmark on both sides, extract a
> common header file to avoid this problem.
> 
> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
> Acked-by: Barry Song <song.bao.hua@hisilicon.com>
> Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
> ---
>  kernel/dma/map_benchmark.c                    | 24 +-------------
>  kernel/dma/map_benchmark.h                    | 31 +++++++++++++++++++
>  .../testing/selftests/dma/dma_map_benchmark.c | 25 +--------------

This needs to go into include/uapi/ instead of using unmaintainable
local includes that poke into other directories.
