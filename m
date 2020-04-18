Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 307E21AEA1C
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Apr 2020 08:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725782AbgDRGG4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 18 Apr 2020 02:06:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:42250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725771AbgDRGG4 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 18 Apr 2020 02:06:56 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E498D21D91;
        Sat, 18 Apr 2020 06:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587190015;
        bh=WVfTj/f0wicy+t8vBw/fJD45Fuu2kRJwZmAYxOS3UvQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b8UbPhRjbWbWB0lFmSKsysivZq8OG+FPcA/gw69hRYh4w4KQI8R1VTXRmOXy2hfV7
         3nL6G8HueB+5O2QI9IPnKZ3nFvvpndulIz164ITtS0hFdcYPG/EFbKxqBj3zuvnl5S
         MRjb7xKw/Pf9T1CSN1pdPRnyCfaedv4TT81Ly+dE=
Date:   Sat, 18 Apr 2020 09:06:51 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Ralph Campbell <rcampbell@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH v9 3/3] MAINTAINERS: add HMM selftests
Message-ID: <20200418060651.GI3083@unreal>
References: <20200417235458.13462-1-rcampbell@nvidia.com>
 <20200417235458.13462-4-rcampbell@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200417235458.13462-4-rcampbell@nvidia.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Apr 17, 2020 at 04:54:58PM -0700, Ralph Campbell wrote:
> Add files for HMM selftests.
>
> Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
> ---
>  MAINTAINERS | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e64e5db31497..072921b7bae2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7729,6 +7729,9 @@ S:	Maintained
>  F:	Documentation/vm/hmm.rst
>  F:	include/linux/hmm*
>  F:	mm/hmm*
> +F:	include/uapi/linux/test_hmm*

This line is not needed anymore.

Thanks

> +F:	lib/test_hmm*
> +F:	tools/testing/selftests/vm/*hmm*
>
>  HOST AP DRIVER
>  M:	Jouni Malinen <j@w1.fi>
> --
> 2.25.2
>
>
