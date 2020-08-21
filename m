Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8116224CBA8
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Aug 2020 05:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbgHUDvh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Aug 2020 23:51:37 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:18601 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727090AbgHUDvg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Aug 2020 23:51:36 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f3f44b90000>; Thu, 20 Aug 2020 20:51:21 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 20 Aug 2020 20:51:35 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 20 Aug 2020 20:51:35 -0700
Received: from [10.2.56.96] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 21 Aug
 2020 03:51:28 +0000
Subject: Re: [PATCH] mm/gup_benchmark: update the documentation in Kconfig
To:     Barry Song <song.bao.hua@hisilicon.com>,
        <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kselftest@vger.kernel.org>
CC:     <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        Keith Busch <keith.busch@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
References: <20200821032546.19992-1-song.bao.hua@hisilicon.com>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <622e5ba7-41e9-0335-1630-cbcdaf9a162f@nvidia.com>
Date:   Thu, 20 Aug 2020 20:51:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200821032546.19992-1-song.bao.hua@hisilicon.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1597981881; bh=OFw05gqtm34jtOGr2u9s+eSTW+9vg7j82ohz9WyBrNw=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=fi9ERSL8dvklD8RB4vq2gFIHipBcnEQz3N2KkExotSl+ktAMRKdtVgaXpfJuBzP2C
         a0jmZIdu7s4rubJNRY5D7uFV3ltRU/MP5HZnU7+MXs+U8Gj7ehoCKptBatREdRtJNN
         J6RmRcJJI5OFOKp5NJVtwM5BG3yvskd0GgnP1Uc0rsR+FjaN42idBgodUZM197IcOI
         hr8zCFzai/IE0uHuUxBgQqxXVOcbcbQICUcwgCimpR7cIriI15YYjd/YNKopJyuqRG
         PTqWaBekanSLdviVIsoq346JFBHCt/GiXxRp0rGDQwpo9FgbMCUUxBFCZaniAEng33
         KENOMf+DJCu8w==
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/20/20 8:25 PM, Barry Song wrote:
> In the beginning, mm/gup_benchmark.c supported get_user_pages_fast()
> only, but right now, it supports the benchmarking of a couple of
> get_user_pages() related calls like:
> * get_user_pages_fast()
> * get_user_pages()
> * pin_user_pages_fast()
> * pin_user_pages()
> The documentation is confusing and needs update.

hmmm, it's not that confusing, given that pin_user_pages() and
get_user_pages() use the same underlying get_user_pages()
implementation.

> 
> Cc: John Hubbard <jhubbard@nvidia.com>
> Cc: Keith Busch <keith.busch@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
> ---
>   mm/Kconfig | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 6c974888f86f..f7c9374da7b3 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -831,10 +831,10 @@ config PERCPU_STATS
>   	  be used to help understand percpu memory usage.
>   
>   config GUP_BENCHMARK
> -	bool "Enable infrastructure for get_user_pages_fast() benchmarking"
> +	bool "Enable infrastructure for get_user_pages() and related calls benchmarking"

If we really want to go to the trouble of tweaking this, then I'd go with
something more like:

"Enable infrastructure for get_user_pages() and pin_user_pages benchmarking"

...but I don't think it really warrants a patch just yet. *However*, my
judgment is skewed right now, because I'm planning a small patchset to split
up gup_benchmark a little bit, and to add some more testing and take advantage
of parts of it to do a dump_page() test. At which point "related calls" would
make more sense, but then it would be different enough that this patch would
still need changing.

So I'm inclined to just recommend leaving this alone for a bit, but if others
want to put it in, I'm OK with that too.

>   	help
>   	  Provides /sys/kernel/debug/gup_benchmark that helps with testing
> -	  performance of get_user_pages_fast().
> +	  performance of get_user_pages() and related calls.
>   
>   	  See tools/testing/selftests/vm/gup_benchmark.c
>   
> 

thanks,
-- 
John Hubbard
NVIDIA
