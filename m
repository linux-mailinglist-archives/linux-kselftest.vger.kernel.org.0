Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 902787224C0
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Jun 2023 13:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232657AbjFELiF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 5 Jun 2023 07:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232624AbjFELiB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 5 Jun 2023 07:38:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEB5513A
        for <linux-kselftest@vger.kernel.org>; Mon,  5 Jun 2023 04:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685965031;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fAIQEofIMC7v8RzKIvVCVe2spFdmLoNCeLo4DX8oh/0=;
        b=hb5p6fEii6WuJ4GERZNuFJfSm9+v2mTfP0oq23Ba3kYaW4eGXu0r0HINBvssnLxMQdb6B4
        VxErznopojSQAhy3n4NDr2Moy6ek3A2V3bPq6oMLH6CpGMeswSoKSlK27lD5bXtBP6E0+N
        Wkb+wukiQeJWQgySkoDvLaTl48RXz90=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-54-TbWLH_cZOtmfHibTEXCgdA-1; Mon, 05 Jun 2023 07:37:07 -0400
X-MC-Unique: TbWLH_cZOtmfHibTEXCgdA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3f70f9995aeso22990875e9.0
        for <linux-kselftest@vger.kernel.org>; Mon, 05 Jun 2023 04:37:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685965026; x=1688557026;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fAIQEofIMC7v8RzKIvVCVe2spFdmLoNCeLo4DX8oh/0=;
        b=bP4eFvlDycyqTLk6t8NWRzMdy6zKokT7cH/FE0h+SrHavMvttDiYg1vp2H+jlb5LQv
         DRc6VlVKQWkiypDCPJ5qX45dgLZtrOFhUOJmyx5L80YsEe4EK5gUd1Q5Hv4shDTBZU6T
         kiwbwTAgwnq4bDt7F0kXt+dNQT3y7Uq2YJSUmQjhUnDG72MzSgF8Wkj7GieWpINeK3jb
         +60xp9DLldCq50+w6njm+8WrspmmwTWsYL0zzIzQt6Q+QDqTdwI85MBzq+AidAKQj6GR
         weqM4f7+H5zQmkQCdBB/1OvUEI7f4zsIn9th2XEjezAa36M+vSz1h8BvidDfncXnHf1X
         lnBQ==
X-Gm-Message-State: AC+VfDxttnlPfoCGu545+F+O2sAYpZghGBwVyxDqlr6r5Lxv5bjacAxN
        oUWfP008kZC1xSbMGm/WvHhtjWx9ZL5AO/qA/P2lHrnxZsSakSknEpXDBBU25g4eI1W/mOY5COJ
        Dx/+opTWVGVE3OtKhWH1sI0q44FoQ
X-Received: by 2002:a7b:ce89:0:b0:3f6:552:8722 with SMTP id q9-20020a7bce89000000b003f605528722mr6649062wmj.18.1685965026173;
        Mon, 05 Jun 2023 04:37:06 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5VGDnaIen5lKCJ5CKH0EbB5zYnqK07QWbo8gZv5KqwMjzuCPkiSLwEQ2p/qW8E3PH5x2JDyg==
X-Received: by 2002:a7b:ce89:0:b0:3f6:552:8722 with SMTP id q9-20020a7bce89000000b003f605528722mr6649046wmj.18.1685965025766;
        Mon, 05 Jun 2023 04:37:05 -0700 (PDT)
Received: from ?IPV6:2003:cb:c737:8f00:ed9:16b8:4e22:5820? (p200300cbc7378f000ed916b84e225820.dip0.t-ipconnect.de. [2003:cb:c737:8f00:ed9:16b8:4e22:5820])
        by smtp.gmail.com with ESMTPSA id u4-20020a7bc044000000b003f70a7b4537sm14074087wmc.36.2023.06.05.04.37.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 04:37:05 -0700 (PDT)
Message-ID: <a3a3b21e-df1c-08bc-2860-8a53134ec172@redhat.com>
Date:   Mon, 5 Jun 2023 13:37:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 06/11] selftests/mm: fix two -Wformat-security warnings
 in uffd builds
Content-Language: en-US
To:     John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Peter Xu <peterx@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
References: <20230603021558.95299-1-jhubbard@nvidia.com>
 <20230603021558.95299-7-jhubbard@nvidia.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230603021558.95299-7-jhubbard@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 03.06.23 04:15, John Hubbard wrote:
> The uffd tests generate two compile time warnings from clang's
> -Wformat-security setting. These trigger at the call sites for
> uffd_test_start() and uffd_test_skip().
> 
> 1) Fix the uffd_test_start() issue by removing the intermediate
> test_name variable (thanks to David Hildenbrand for showing how to do
> this).
> 
> 2) Fix the uffd_test_skip() issue by observing that there is no need for
> a macro and a variable args approach, because all callers of
> uffd_test_skip() pass in a simple char* string, without any format
> specifiers. So just change uffd_test_skip() into a regular C function.
> 
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Peter Xu <peterx@redhat.com>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>   tools/testing/selftests/mm/uffd-unit-tests.c | 16 ++++++----------
>   1 file changed, 6 insertions(+), 10 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/uffd-unit-tests.c b/tools/testing/selftests/mm/uffd-unit-tests.c
> index 269c86768a02..04d91f144d1c 100644
> --- a/tools/testing/selftests/mm/uffd-unit-tests.c
> +++ b/tools/testing/selftests/mm/uffd-unit-tests.c
> @@ -109,12 +109,11 @@ static void uffd_test_pass(void)
>   		ksft_inc_fail_cnt();		\
>   	} while (0)
>   
> -#define  uffd_test_skip(...)  do {		\
> -		printf("skipped [reason: ");	\
> -		printf(__VA_ARGS__);		\
> -		printf("]\n");			\
> -		ksft_inc_xskip_cnt();		\
> -	} while (0)
> +static void uffd_test_skip(const char *message)
> +{
> +	printf("skipped [reason: %s]\n", message);
> +	ksft_inc_xskip_cnt();
> +}
>   
>   /*
>    * Returns 1 if specific userfaultfd supported, 0 otherwise.  Note, we'll
> @@ -1149,7 +1148,6 @@ int main(int argc, char *argv[])
>   	uffd_test_case_t *test;
>   	mem_type_t *mem_type;
>   	uffd_test_args_t args;
> -	char test_name[128];
>   	const char *errmsg;
>   	int has_uffd, opt;
>   	int i, j;
> @@ -1192,10 +1190,8 @@ int main(int argc, char *argv[])
>   			mem_type = &mem_types[j];
>   			if (!(test->mem_targets & mem_type->mem_flag))
>   				continue;
> -			snprintf(test_name, sizeof(test_name),
> -				 "%s on %s", test->name, mem_type->name);
>   
> -			uffd_test_start(test_name);
> +			uffd_test_start("%s on %s", test->name, mem_type->name);
>   			if (!uffd_feature_supported(test)) {
>   				uffd_test_skip("feature missing");
>   				continue;

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

