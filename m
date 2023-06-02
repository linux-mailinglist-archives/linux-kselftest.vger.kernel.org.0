Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7886B7207A9
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Jun 2023 18:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235196AbjFBQeg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Jun 2023 12:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236771AbjFBQee (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Jun 2023 12:34:34 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B29D91AB;
        Fri,  2 Jun 2023 09:34:29 -0700 (PDT)
Received: from [192.168.10.48] (unknown [119.152.150.198])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C59A96600864;
        Fri,  2 Jun 2023 17:34:25 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1685723668;
        bh=fjlwb5arvmBAQNcfoxZJkePBtmaOQ4pj0FJSNiyAE2o=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=e42LuCJv7LqiTiu3Im0lYfwpHfzQSzS/Y/gXtA29A1+eOrv+ykOVoXbFIdPMsiask
         /9PHfbeQJPIowbAkkP6aTPicTA9722HqAAwIpmw8Q5BJBWV5djZEk6STwb62oKrrXu
         LtI0ImX05L28sAAwWq5XWjrhucaCKDI2MMDUnIwPIEZzkVsuNPbSmDEF4l2w95rJiD
         5Ink1twL7Oe436x6ZY+adnHRXdn+9V7moPYsVWmcSF0kPHl37aE0VvPOdF6/Co+zCo
         lss44eZgCKe933qsQD4ZsXeSJ7+3DtfXFEhaCmYeYNfp+OASaQy6Va+3OD8cNR7E4u
         S81v46vWHtBZA==
Message-ID: <740b9d62-ba83-0297-aa2f-66af29f9afbe@collabora.com>
Date:   Fri, 2 Jun 2023 21:34:21 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        David Hildenbrand <david@redhat.com>,
        Peter Xu <peterx@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 12/12] selftests/mm: fix uffd-unit-tests.c build failure
 due to missing MADV_COLLAPSE
Content-Language: en-US
To:     John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20230602013358.900637-1-jhubbard@nvidia.com>
 <20230602013358.900637-13-jhubbard@nvidia.com>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20230602013358.900637-13-jhubbard@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 6/2/23 6:33 AM, John Hubbard wrote:
> MADV_PAGEOUT, MADV_POPULATE_READ, MADV_COLLAPSE are conditionally
> defined as necessary. However, that was being done in .c files, and a
> new build failure came up that would have been automatically avoided had
> these been in a common header file.
There is a better way. Just like I've mentioned that building in-tree
kernel headers and then mm selftests don't produce any build failures as
they pick up in-tree compiled kernel header files. Don't move these
definations to vm_util.h. Instead include asm-generic/mman-common.h which
has all these definitions already. I've just removed what you have removed
in this patch and include asm-generic/mman-common.h. It builds fine. But
then there are more duplicated definition warnings.

> 
> So consolidate and move them all to vm_util.h, which fixes the build
> failure.
> 
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>  tools/testing/selftests/mm/cow.c        |  7 -------
>  tools/testing/selftests/mm/khugepaged.c | 10 ----------
>  tools/testing/selftests/mm/vm_util.h    | 10 ++++++++++
>  3 files changed, 10 insertions(+), 17 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/cow.c b/tools/testing/selftests/mm/cow.c
> index dc9d6fe86028..8882b05ec9c8 100644
> --- a/tools/testing/selftests/mm/cow.c
> +++ b/tools/testing/selftests/mm/cow.c
> @@ -30,13 +30,6 @@
>  #include "../kselftest.h"
>  #include "vm_util.h"
>  
> -#ifndef MADV_PAGEOUT
> -#define MADV_PAGEOUT 21
> -#endif
> -#ifndef MADV_COLLAPSE
> -#define MADV_COLLAPSE 25
> -#endif
> -
>  static size_t pagesize;
>  static int pagemap_fd;
>  static size_t thpsize;
> diff --git a/tools/testing/selftests/mm/khugepaged.c b/tools/testing/selftests/mm/khugepaged.c
> index 97adc0f34f9c..e88ee039d0eb 100644
> --- a/tools/testing/selftests/mm/khugepaged.c
> +++ b/tools/testing/selftests/mm/khugepaged.c
> @@ -22,16 +22,6 @@
>  
>  #include "vm_util.h"
>  
> -#ifndef MADV_PAGEOUT
> -#define MADV_PAGEOUT 21
> -#endif
> -#ifndef MADV_POPULATE_READ
> -#define MADV_POPULATE_READ 22
> -#endif
> -#ifndef MADV_COLLAPSE
> -#define MADV_COLLAPSE 25
> -#endif
> -
>  #define BASE_ADDR ((void *)(1UL << 30))
>  static unsigned long hpage_pmd_size;
>  static unsigned long page_size;
> diff --git a/tools/testing/selftests/mm/vm_util.h b/tools/testing/selftests/mm/vm_util.h
> index 7f5aac0ac680..f04f82771cd0 100644
> --- a/tools/testing/selftests/mm/vm_util.h
> +++ b/tools/testing/selftests/mm/vm_util.h
> @@ -41,3 +41,13 @@ unsigned long default_huge_page_size(void);
>  
>  #define PAGEMAP_PRESENT(ent)	(((ent) & (1ull << 63)) != 0)
>  #define PAGEMAP_PFN(ent)	((ent) & ((1ull << 55) - 1))
> +
> +#ifndef MADV_PAGEOUT
> +#define MADV_PAGEOUT 21
> +#endif
> +#ifndef MADV_POPULATE_READ
> +#define MADV_POPULATE_READ 22
> +#endif
> +#ifndef MADV_COLLAPSE
> +#define MADV_COLLAPSE 25
> +#endif

-- 
BR,
Muhammad Usama Anjum
