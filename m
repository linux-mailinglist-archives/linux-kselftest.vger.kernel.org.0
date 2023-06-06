Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B336723A74
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jun 2023 09:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236002AbjFFHvf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Jun 2023 03:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237497AbjFFHu5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Jun 2023 03:50:57 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B52A30D8;
        Tue,  6 Jun 2023 00:47:16 -0700 (PDT)
Received: from [192.168.10.48] (unknown [119.152.150.198])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 20A026602242;
        Tue,  6 Jun 2023 08:47:00 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686037623;
        bh=GfoUoLYLzdTif97190CNZHOIFaRq93HJHWohOIQjbMI=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=bJGcc4TTRsfeRoS8/MtJUS3/uQogg/+4uHZZ2yDYhcbcbvSUiruWb7k5nGISJnmnt
         eG8I4VNH35NScO0UTSZwQc5d4fkIAEI63Lyn5qy7xYcRC+b/ro452KOMeW2rGZdm74
         mCiGQuWOyA7blTC+cNZsHyLaEMoErml9f8pMpIK32uMkJvS+IdZU0WAtKfhwvG0msT
         g9CFmLEmwL7HdxbNAxmsIpIV0OffP1fXVPYYeLdVJBFey3iybW/pPRKw4/Tu2lYzIl
         AF3UA8SkuL54PveepDsoaArwFJFu3y2ugb+x3EO9kUtZG/Bm1gaq7pnSA+goAW/4nk
         K3+1bida8F2wA==
Message-ID: <7867afce-0eec-d01c-fbcb-82936f405981@collabora.com>
Date:   Tue, 6 Jun 2023 12:46:57 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        David Hildenbrand <david@redhat.com>,
        Peter Xu <peterx@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 01/11] selftests/mm: fix uffd-stress unused function
 warning
Content-Language: en-US
To:     John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20230606071637.267103-1-jhubbard@nvidia.com>
 <20230606071637.267103-2-jhubbard@nvidia.com>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20230606071637.267103-2-jhubbard@nvidia.com>
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
> uffd_minor_feature() was unused. Remove it in order to fix the
> associated clang build warning.
> 
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
Tested-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

> ---
>  tools/testing/selftests/mm/uffd-stress.c | 10 ----------
>  1 file changed, 10 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/uffd-stress.c b/tools/testing/selftests/mm/uffd-stress.c
> index f1ad9eef1c3a..995ff13e74c7 100644
> --- a/tools/testing/selftests/mm/uffd-stress.c
> +++ b/tools/testing/selftests/mm/uffd-stress.c
> @@ -88,16 +88,6 @@ static void uffd_stats_reset(struct uffd_args *args, unsigned long n_cpus)
>  	}
>  }
>  
> -static inline uint64_t uffd_minor_feature(void)
> -{
> -	if (test_type == TEST_HUGETLB && map_shared)
> -		return UFFD_FEATURE_MINOR_HUGETLBFS;
> -	else if (test_type == TEST_SHMEM)
> -		return UFFD_FEATURE_MINOR_SHMEM;
> -	else
> -		return 0;
> -}
> -
>  static void *locking_thread(void *arg)
>  {
>  	unsigned long cpu = (unsigned long) arg;

-- 
BR,
Muhammad Usama Anjum
