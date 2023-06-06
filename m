Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C13E5723AC7
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jun 2023 09:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235908AbjFFH6n (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Jun 2023 03:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236167AbjFFH60 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Jun 2023 03:58:26 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A6B01FD7;
        Tue,  6 Jun 2023 00:55:46 -0700 (PDT)
Received: from [192.168.10.48] (unknown [119.152.150.198])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 5D6516602242;
        Tue,  6 Jun 2023 08:55:36 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686038138;
        bh=16/hORSZZsCnXMLprufrbcrkPHQ/ZtHj8guWXjMMmvo=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=KvYkoem2SbKT/M9jRwwrkYvg017GNTT8CVZYApJnmMd/C6ZXaqSOweAc7q78EcQEG
         z/rWjRXBVfC4LAIOwPRedMxCK5jS+4mKCyGvIRWtLhobIr87rBPOdaF28aCKk32+Bn
         acMDIJPbi8HrrI7Em7/euPHXXZAZQcdNl+bedQZCU4BvkjihpC85p0tUr5TMgK+qp0
         nIN/BBsZm3WwR+1toXYUFYtujzKi0UweDvwgxlxUElJmLCRDXW2upnkB2R8JwEItYv
         CLZExNDRu+Pe33+Ybh09iZXzon15y/NzmVYOMfQOScCGpHik/qEJlv/GLverLq3+a2
         2gBYhWj9+Ak2g==
Message-ID: <22d7a678-7f8b-a6ef-d280-f5c0ad3e5dbb@collabora.com>
Date:   Tue, 6 Jun 2023 12:55:32 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        David Hildenbrand <david@redhat.com>,
        Peter Xu <peterx@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 08/11] selftests/mm: fix build failures due to missing
 MADV_COLLAPSE
Content-Language: en-US
To:     John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20230606071637.267103-1-jhubbard@nvidia.com>
 <20230606071637.267103-9-jhubbard@nvidia.com>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20230606071637.267103-9-jhubbard@nvidia.com>
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

On 6/6/23 12:16 PM, John Hubbard wrote:
> MADV_PAGEOUT, MADV_POPULATE_READ, MADV_COLLAPSE are conditionally
> defined as necessary. However, that was being done in .c files, and a
> new build failure came up that would have been automatically avoided had
> these been in a common header file.
> 
> So consolidate and move them all to vm_util.h, which fixes the build
> failure.
> 
> An alternative approach from Muhammad Usama Anjum was: rely on "make
> headers" being required, and include asm-generic/mman-common.h. This
> works in the sense that it builds, but it still generates warnings about
> duplicate MADV_* symbols, and the goal here is to get a fully clean (no
> warnings) build here.
> 
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
Tested-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

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
> index b950bd16083a..07f39ed2efba 100644
> --- a/tools/testing/selftests/mm/vm_util.h
> +++ b/tools/testing/selftests/mm/vm_util.h
> @@ -63,3 +63,13 @@ int uffd_register_with_ioctls(int uffd, void *addr, uint64_t len,
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
