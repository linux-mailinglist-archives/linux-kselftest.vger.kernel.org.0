Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB1026D59B1
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Apr 2023 09:32:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233904AbjDDHcN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 4 Apr 2023 03:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233796AbjDDHcL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 4 Apr 2023 03:32:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 170B7123
        for <linux-kselftest@vger.kernel.org>; Tue,  4 Apr 2023 00:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680593479;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UtZR8/RCDui641OHVeuDBdP9asgKQnGNK+6bWZHRowc=;
        b=dy22+uNQuA43mJJtqgUQnJx5WFC/DSQ22OQAPmh9Bovj+8FHHfR0Puct6LVOkOWYSviQbJ
        w7of5P8HbYyvbzD7+yGsZnkpcKlHnqiv5c1ZkXm8bKPBLIqMHqu+wDZOg3VM/ak8MWA+qo
        MOvruxC2+xs6RKJf97fHgi1rAu1ceNY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-7Ff7KDVXObCnrF9Jl-Fc9w-1; Tue, 04 Apr 2023 03:31:18 -0400
X-MC-Unique: 7Ff7KDVXObCnrF9Jl-Fc9w-1
Received: by mail-wm1-f70.google.com with SMTP id bh18-20020a05600c3d1200b003f05a99b571so1280516wmb.8
        for <linux-kselftest@vger.kernel.org>; Tue, 04 Apr 2023 00:31:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680593477;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UtZR8/RCDui641OHVeuDBdP9asgKQnGNK+6bWZHRowc=;
        b=HO3K9EkFPY7ITGbWpkyNy+s/8MHtowzd/fXRe8M8vgsjz8HunzVYgfNTG6sepsoxDI
         xjxY8GaIQ/H88+ZLbKZJ/048kB7U1VZ1vqzEEQJPdXStlLFp4DrwuinSO967PgIXY7jU
         q6kpBU7N+mlNJ2/70tdYNy8QJod5vCfvrAM0GVI6CDvOSfiSfMp0Mmy4oqmACkXH1cHh
         PIGX1JxPWShO0hw25Ws9Wvm9XazxLxO0log5tMpaftcMcyczH8BQ6D+8WSj6Hq9qy5SK
         riWJUmzh+qWORmVJsXTsHLbq/QjPBIExCs2ziHrddK53h0z/s7cza7AX+KHrfzS/h40r
         /xng==
X-Gm-Message-State: AAQBX9fbVUlAd1+8LJaEQErv9tpNXk98d4hDkxz6qaz48f7rqJ7Ewh5d
        pvCYL9mP2qL2TWlVcCSg1lNYSypn15b9UIDLzWlQiU3sNVT4teIVm23o7UttHEohMG4vDcAGA2C
        N9hcIQ/fa27aNm98Vk3NXdwKw4LgI
X-Received: by 2002:a05:600c:2291:b0:3ee:5d1d:6c4e with SMTP id 17-20020a05600c229100b003ee5d1d6c4emr1349582wmf.16.1680593477072;
        Tue, 04 Apr 2023 00:31:17 -0700 (PDT)
X-Google-Smtp-Source: AKy350bYbI3qNHfFi766ASxpwJRAZ5scFYZVV2/fpRxOFnzGf88jPExHEZWHMpCgQEnRstVcXJdH4w==
X-Received: by 2002:a05:600c:2291:b0:3ee:5d1d:6c4e with SMTP id 17-20020a05600c229100b003ee5d1d6c4emr1349562wmf.16.1680593476713;
        Tue, 04 Apr 2023 00:31:16 -0700 (PDT)
Received: from ?IPV6:2003:cb:c709:b600:e63:6c3b:7b5d:f439? (p200300cbc709b6000e636c3b7b5df439.dip0.t-ipconnect.de. [2003:cb:c709:b600:e63:6c3b:7b5d:f439])
        by smtp.gmail.com with ESMTPSA id ip21-20020a05600ca69500b003edf2ae2432sm20873735wmb.7.2023.04.04.00.31.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Apr 2023 00:31:16 -0700 (PDT)
Message-ID: <5c415fa5-1637-883d-8136-fc4280274406@redhat.com>
Date:   Tue, 4 Apr 2023 09:31:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] selftests/mm: fix memory leak in child_memcmp_fn
To:     Feng Jiang <jiangfeng@kylinos.cn>, akpm@linux-foundation.org,
        shuah@kernel.org
Cc:     linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ming Xie <xieming@kylinos.cn>
References: <20230404031234.78272-1-jiangfeng@kylinos.cn>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230404031234.78272-1-jiangfeng@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 04.04.23 05:12, Feng Jiang wrote:
> The allocated memory should be freed on return.
> 
> Signed-off-by: Feng Jiang <jiangfeng@kylinos.cn>
> Suggested-by: Ming Xie <xieming@kylinos.cn>
> ---
>   tools/testing/selftests/mm/cow.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/mm/cow.c b/tools/testing/selftests/mm/cow.c
> index 0eb2e8180aa5..c0dd2dfca51b 100644
> --- a/tools/testing/selftests/mm/cow.c
> +++ b/tools/testing/selftests/mm/cow.c
> @@ -162,6 +162,10 @@ static int child_memcmp_fn(char *mem, size_t size,
>   {
>   	char *old = malloc(size);
>   	char buf;
> +	int ret;
> +
> +	if (!old)
> +		return -ENOMEM;
>   
>   	/* Backup the original content. */
>   	memcpy(old, mem, size);
> @@ -172,7 +176,10 @@ static int child_memcmp_fn(char *mem, size_t size,
>   		;
>   
>   	/* See if we still read the old values. */
> -	return memcmp(old, mem, size);
> +	ret = memcmp(old, mem, size);
> +	free(old);
> +
> +	return ret;
>   }
>   
>   static int child_vmsplice_memcmp_fn(char *mem, size_t size,

NAK, the whole point of this function is that the child process will 
exit immediately after executing this function, cleaning up automatically.

-- 
Thanks,

David / dhildenb

