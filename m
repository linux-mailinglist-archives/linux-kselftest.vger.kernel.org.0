Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E8136D59B2
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Apr 2023 09:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233913AbjDDHc0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 4 Apr 2023 03:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233943AbjDDHcU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 4 Apr 2023 03:32:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8349CE49
        for <linux-kselftest@vger.kernel.org>; Tue,  4 Apr 2023 00:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680593491;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=piM6K+EwFCqEvMxxQyo5kGLtqlX28i2Vbt7uZeX0+S4=;
        b=b0E8FuRL7yPnO+y118Gi3v3lWJgvm7wB+i3VNrULyydEQZV9sTM5WvXLbwVMexgFzTg38J
        z4ZZlcD2+ysy2zG53tldFtnZZ7rua4BwyPddOpy2Ol/l/y7QrdX0O6zvhhOWmLU5cM3z+7
        ETY9Q0eYX49m4/5di0I6Nn292Kakp0s=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-j5Wmtjd1MzCaXSp3nadQkg-1; Tue, 04 Apr 2023 03:31:28 -0400
X-MC-Unique: j5Wmtjd1MzCaXSp3nadQkg-1
Received: by mail-wm1-f71.google.com with SMTP id l18-20020a05600c1d1200b003ef7b61e2fdso9849803wms.4
        for <linux-kselftest@vger.kernel.org>; Tue, 04 Apr 2023 00:31:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680593487;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=piM6K+EwFCqEvMxxQyo5kGLtqlX28i2Vbt7uZeX0+S4=;
        b=GtP9KhDE6rFu0scqKsFcNKapWzGXUv6DgtQgcDR+cF/DUzZTTutWicNX2XPUkpU+u7
         FsXHzHPOlY5Ao7QVGk5XEqk4/1krDEAwATOkucSoqoZJTdI6eKxZqnxSmXpF/6XtAGyp
         ObqeFymKsyualIuAIIOvuiIjz7jVjLREHBKbMg3G6EggQxvI0b8xfzGyMB1n8Op7hUlN
         94w15S/uNKL8Hnc940KbdZ6SdQTZuDn9rVsINq5aTPd0DjKkP7r3SxcIJuKjiarGjwp1
         dalV78rUx9MLjuFPGSxl+NwD4sryWj0wXBJDA39c+AsCEf7rC+NwW4Qb0FwJ9T/YuHnc
         US/w==
X-Gm-Message-State: AAQBX9dKNFTJAbnTobrU7FoIdaExBiPvFs2oIY/pW/8/Khcj3AZblVbh
        pFspG2964Ivpd3+McoP8SBVG16530UAuGSyjWsSkz1l8XyabpIxD0Do0Z7oJko6lgGcGEEFslqw
        2fpvD4/4fSOKM0IQzZ7rRvPIoOCQW0a8MD61k
X-Received: by 2002:adf:f54c:0:b0:2e4:d939:11b9 with SMTP id j12-20020adff54c000000b002e4d93911b9mr814381wrp.48.1680593487516;
        Tue, 04 Apr 2023 00:31:27 -0700 (PDT)
X-Google-Smtp-Source: AKy350bX5AUGeXYCV++RJ5DqqSdVGCKkIlGhhLJN5W7tIGuU26d7QV8MNlVc0PP0ECp/ATZgTRdfSw==
X-Received: by 2002:adf:f54c:0:b0:2e4:d939:11b9 with SMTP id j12-20020adff54c000000b002e4d93911b9mr814356wrp.48.1680593487191;
        Tue, 04 Apr 2023 00:31:27 -0700 (PDT)
Received: from ?IPV6:2003:cb:c709:b600:e63:6c3b:7b5d:f439? (p200300cbc709b6000e636c3b7b5df439.dip0.t-ipconnect.de. [2003:cb:c709:b600:e63:6c3b:7b5d:f439])
        by smtp.gmail.com with ESMTPSA id y13-20020adff14d000000b002c55306f6edsm11570953wro.54.2023.04.04.00.31.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Apr 2023 00:31:26 -0700 (PDT)
Message-ID: <4373532a-5e75-f8f6-cc91-ed5a1cae9a1b@redhat.com>
Date:   Tue, 4 Apr 2023 09:31:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] selftests/mm: fix resource leaks in
 child_vmsplice_memcmp_fn
Content-Language: en-US
To:     Feng Jiang <jiangfeng@kylinos.cn>, akpm@linux-foundation.org,
        shuah@kernel.org
Cc:     linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ming Xie <xieming@kylinos.cn>
References: <20230404031256.78330-1-jiangfeng@kylinos.cn>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230404031256.78330-1-jiangfeng@kylinos.cn>
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
> When the function returns, the 'new' and 'old' are not freed
> and the 'fds[]' are not closed, which can lead to resource leaks.
> 
> Signed-off-by: Feng Jiang <jiangfeng@kylinos.cn>
> Suggested-by: Ming Xie <xieming@kylinos.cn>
> ---
>   tools/testing/selftests/mm/cow.c | 43 ++++++++++++++++++++++++--------
>   1 file changed, 32 insertions(+), 11 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/cow.c b/tools/testing/selftests/mm/cow.c
> index c0dd2dfca51b..b8aec05d56f4 100644
> --- a/tools/testing/selftests/mm/cow.c
> +++ b/tools/testing/selftests/mm/cow.c
> @@ -193,26 +193,38 @@ static int child_vmsplice_memcmp_fn(char *mem, size_t size,
>   	char *old, *new;
>   	int fds[2];
>   	char buf;
> +	int ret;
>   
>   	old = malloc(size);
>   	new = malloc(size);
> +	if (!old || !new) {
> +		ret = -ENOMEM;
> +		goto free;
> +	}
>   
>   	/* Backup the original content. */
>   	memcpy(old, mem, size);
>   
> -	if (pipe(fds) < 0)
> -		return -errno;
> +	if (pipe(fds) < 0) {
> +		ret = -errno;
> +		goto free;
> +	}
>   
>   	/* Trigger a read-only pin. */
>   	transferred = vmsplice(fds[1], &iov, 1, 0);
> -	if (transferred < 0)
> -		return -errno;
> -	if (transferred == 0)
> -		return -EINVAL;
> +	if (transferred < 0) {
> +		ret = -errno;
> +		goto close_pipe;
> +	} else if (transferred == 0) {
> +		ret = -EINVAL;
> +		goto close_pipe;
> +	}
>   
>   	/* Unmap it from our page tables. */
> -	if (munmap(mem, size) < 0)
> -		return -errno;
> +	if (munmap(mem, size) < 0) {
> +		ret = -errno;
> +		goto close_pipe;
> +	}
>   
>   	/* Wait until the parent modified it. */
>   	write(comm_pipes->child_ready[1], "0", 1);
> @@ -222,11 +234,20 @@ static int child_vmsplice_memcmp_fn(char *mem, size_t size,
>   	/* See if we still read the old values via the pipe. */
>   	for (total = 0; total < transferred; total += cur) {
>   		cur = read(fds[0], new + total, transferred - total);
> -		if (cur < 0)
> -			return -errno;
> +		if (cur < 0) {
> +			ret = -errno;
> +			goto close_pipe;
> +		}
>   	}
>   
> -	return memcmp(old, new, transferred);
> +	ret = memcmp(old, new, transferred);
> +close_pipe:
> +	close(fds[0]);
> +	close(fds[1]);
> +free:
> +	free(old);
> +	free(new);
> +	return ret;
>   }
>   
>   typedef int (*child_fn)(char *mem, size_t size, struct comm_pipes *comm_pipes);

NAK, the whole point of this function is that the child process will 
exit immediately after executing this function, cleaning up automatically.

-- 
Thanks,

David / dhildenb

