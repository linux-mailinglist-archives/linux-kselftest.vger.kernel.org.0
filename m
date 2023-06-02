Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24DA671FF3D
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Jun 2023 12:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235488AbjFBK0b (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Jun 2023 06:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235460AbjFBKZY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Jun 2023 06:25:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33E4A1BF
        for <linux-kselftest@vger.kernel.org>; Fri,  2 Jun 2023 03:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685701432;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Pkvu8Jzh1WTkXWcQkQ56qL406K+KbKZMazpgBAdDI3Y=;
        b=JNMmCiJIJ2TG1yuKvauNPHtBQN1JkTf+qcN4OOKXrwJLIpBsCPIGT72M0iHm36PzcpL5rp
        qOO2FsFz4J/YA4GiJzwS48bRbXPOzJ/HMmkpWQlruVg1MWGpOiLA5o+G9yNKelHnXQtNer
        YCHPs9GnbpjJ3kREtm6EB69UR+gnlHY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-466-VwSTbNdJPEqGm_nItVobzw-1; Fri, 02 Jun 2023 06:23:51 -0400
X-MC-Unique: VwSTbNdJPEqGm_nItVobzw-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-30ae9958ff6so1046661f8f.1
        for <linux-kselftest@vger.kernel.org>; Fri, 02 Jun 2023 03:23:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685701430; x=1688293430;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pkvu8Jzh1WTkXWcQkQ56qL406K+KbKZMazpgBAdDI3Y=;
        b=MsP6Tcja09DN1rhzIq67cIzULq/Gd99FQ4axrt4tISKNk5SuLAH7d06fLCN+dKHeL7
         flpioCkmBsm9jNvz1CwuA05L/gyqVnbZicQoTVUaVlErxwAQDZd3KYZ7Ib7xJY4EYxlw
         gZ8j1Dh9wRz7JayyLWpnsT07YzikuZAlF3Wya8O8LH59JHqiAnaaBdR+M4F+xB5WyJIW
         b2Aaldy8SYdoOVlnVQSt9tJN8BlrZkG2e0szwyhxpznPCmstqU8zTVTkcW5yCQp8tJVJ
         L2P7urm55qmVwfj92RKhrCW/JT4kDUA5UPKBkFoznMeH7Jj3FZfItJH7ZLvzl3/bS88P
         HIEA==
X-Gm-Message-State: AC+VfDywh/UJ+I4c42HNCS/fvLKx/cehZTv2/cdujoxbpHJTDJQ+nLkf
        mgOykkpMV9EgXkUOdgc8G/DjA6aX67gK30NhF0yEdpgDprZ4OJPym2LniGur/9bIATjS5MwT17d
        4e4cxbA9FQzVZoBqdADFSHCgYh8TP
X-Received: by 2002:a5d:5388:0:b0:309:49e6:9047 with SMTP id d8-20020a5d5388000000b0030949e69047mr3343100wrv.16.1685701430153;
        Fri, 02 Jun 2023 03:23:50 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4rOM+7YVpGv4YuqoHKVbMsATvwXbHiDehLJ7cyCcbErOZ/UZLOKYIVv1Qxrb9F4LYHp1H2VQ==
X-Received: by 2002:a5d:5388:0:b0:309:49e6:9047 with SMTP id d8-20020a5d5388000000b0030949e69047mr3343087wrv.16.1685701429944;
        Fri, 02 Jun 2023 03:23:49 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f2e:ae00:f2e3:50e0:73f7:451? (p200300d82f2eae00f2e350e073f70451.dip0.t-ipconnect.de. [2003:d8:2f2e:ae00:f2e3:50e0:73f7:451])
        by smtp.gmail.com with ESMTPSA id e12-20020a5d594c000000b0030ae16132besm1268322wri.12.2023.06.02.03.23.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jun 2023 03:23:49 -0700 (PDT)
Message-ID: <989cca4f-f928-b739-5225-3f7e1c5de0e5@redhat.com>
Date:   Fri, 2 Jun 2023 12:23:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 12/12] selftests/mm: fix uffd-unit-tests.c build failure
 due to missing MADV_COLLAPSE
Content-Language: en-US
To:     John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Peter Xu <peterx@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
References: <20230602013358.900637-1-jhubbard@nvidia.com>
 <20230602013358.900637-13-jhubbard@nvidia.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230602013358.900637-13-jhubbard@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 02.06.23 03:33, John Hubbard wrote:
> MADV_PAGEOUT, MADV_POPULATE_READ, MADV_COLLAPSE are conditionally
> defined as necessary. However, that was being done in .c files, and a
> new build failure came up that would have been automatically avoided had
> these been in a common header file.
> 
> So consolidate and move them all to vm_util.h, which fixes the build
> failure.
> 
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>   tools/testing/selftests/mm/cow.c        |  7 -------
>   tools/testing/selftests/mm/khugepaged.c | 10 ----------
>   tools/testing/selftests/mm/vm_util.h    | 10 ++++++++++
>   3 files changed, 10 insertions(+), 17 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/cow.c b/tools/testing/selftests/mm/cow.c
> index dc9d6fe86028..8882b05ec9c8 100644
> --- a/tools/testing/selftests/mm/cow.c
> +++ b/tools/testing/selftests/mm/cow.c
> @@ -30,13 +30,6 @@
>   #include "../kselftest.h"
>   #include "vm_util.h"
>   
> -#ifndef MADV_PAGEOUT
> -#define MADV_PAGEOUT 21
> -#endif
> -#ifndef MADV_COLLAPSE
> -#define MADV_COLLAPSE 25
> -#endif
> -
>   static size_t pagesize;
>   static int pagemap_fd;
>   static size_t thpsize;
> diff --git a/tools/testing/selftests/mm/khugepaged.c b/tools/testing/selftests/mm/khugepaged.c
> index 97adc0f34f9c..e88ee039d0eb 100644
> --- a/tools/testing/selftests/mm/khugepaged.c
> +++ b/tools/testing/selftests/mm/khugepaged.c
> @@ -22,16 +22,6 @@
>   
>   #include "vm_util.h"
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
>   #define BASE_ADDR ((void *)(1UL << 30))
>   static unsigned long hpage_pmd_size;
>   static unsigned long page_size;
> diff --git a/tools/testing/selftests/mm/vm_util.h b/tools/testing/selftests/mm/vm_util.h
> index 7f5aac0ac680..f04f82771cd0 100644
> --- a/tools/testing/selftests/mm/vm_util.h
> +++ b/tools/testing/selftests/mm/vm_util.h
> @@ -41,3 +41,13 @@ unsigned long default_huge_page_size(void);
>   
>   #define PAGEMAP_PRESENT(ent)	(((ent) & (1ull << 63)) != 0)
>   #define PAGEMAP_PFN(ent)	((ent) & ((1ull << 55) - 1))
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


Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

