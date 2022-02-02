Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED6774A7767
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Feb 2022 19:01:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233834AbiBBSBZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Feb 2022 13:01:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232305AbiBBSBZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Feb 2022 13:01:25 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E89C061714
        for <linux-kselftest@vger.kernel.org>; Wed,  2 Feb 2022 10:01:25 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id r144so36789iod.9
        for <linux-kselftest@vger.kernel.org>; Wed, 02 Feb 2022 10:01:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rs6cylvIq9qI+0M8hTCu9FcoUVmSzH0x8j8OjYEAN3c=;
        b=R1IlwvcrOMGu4WNCG8qm9arYJF2GN5LO7mzw/i8cvKjjtLdVDPBARchopPtNE3hk4e
         X8y1mUNSdNX5iTgsGFV+v1kRUf7tzd20ekyCqb6kOJbMfIihYc5gCbDV4b0q0M1H4cVS
         C3xmnta+T6jQvkLR+7iutP2LOTvzRzDS+Qb1I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rs6cylvIq9qI+0M8hTCu9FcoUVmSzH0x8j8OjYEAN3c=;
        b=wHDMhSV4Bbph0fXT7idJOwa54nWwBETufIx3f1TQx2RYHytUa1jXENJs+q6udMICwm
         Y9w7LbOCxQYJvcw8CKCqNa/p8YKXAc6IT8ZrmtkxX7oqEMOAnMYfeI+SbQT+YzcT1F1K
         yP3wjqO9NyxiL9h8TcLAxDpckHk5GpklXqG6BhUQStjeG8M3LzaZ6OMAcXA6dzWfysXV
         yKkE+y9C4MKAkUOJVADzgnrC+hNX1Xu3wYBsj6mWVEzLu5asDNLiqvzVY/vJVVuBBtG1
         Egs1aMtGuFtoyjn4aJoO+gW8FA9iqvA07QR/m8lX2b/Fa3t4zgWBu95prvwfjMd4bT6Z
         gyDA==
X-Gm-Message-State: AOAM531FoPmLWqsmiix6Gt8kHYQVzjuBZKTEQSjKrR7OXFJuIgAoevEf
        YF5gRk4YWn9+6hsUwJKVoiSfHw==
X-Google-Smtp-Source: ABdhPJzqoR0cwM2uEmbGvwhyKMdRHr8SgxZk4Jo2dWgEyMznbgfy6zWbJsZO9hKOuvQugS6pu48dmg==
X-Received: by 2002:a05:6638:2587:: with SMTP id s7mr8951598jat.315.1643824884656;
        Wed, 02 Feb 2022 10:01:24 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id k14sm22128397ilv.74.2022.02.02.10.01.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Feb 2022 10:01:24 -0800 (PST)
Subject: Re: [PATCH V2 1/4] selftests/sgx: Fix NULL-pointer-dereference upon
 early test failure
To:     Reinette Chatre <reinette.chatre@intel.com>, jarkko@kernel.org,
        dave.hansen@linux.intel.com, linux-sgx@vger.kernel.org,
        shuah@kernel.org
Cc:     linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <cover.1643754040.git.reinette.chatre@intel.com>
 <89824888783fd8e770bfc64530c7549650a41851.1643754040.git.reinette.chatre@intel.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <b8ee2381-d1a2-89c6-d199-15b0fdba0553@linuxfoundation.org>
Date:   Wed, 2 Feb 2022 11:01:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <89824888783fd8e770bfc64530c7549650a41851.1643754040.git.reinette.chatre@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/1/22 3:47 PM, Reinette Chatre wrote:
> == Background ==
> 
> The SGX selftests track parts of the enclave binaries in an array:
> encl->segment_tbl[]. That array is dynamically allocated early
> (but not first) in the test's lifetime. The array is referenced
> at the end of the test in encl_delete().
> 
> == Problem ==
> 
> encl->segment_tbl[] can be NULL if the test fails before its
> allocation. That leads to a NULL-pointer-dereference in encl_delete().
> This is triggered during early failures of the selftest like if the
> enclave binary ("test_encl.elf") is deleted.
> 
> == Solution ==
> 

"==" usage looks a bit odd in the change log.
  
> Ensure encl->segment_tbl[] is valid before attempting to access
> its members. The offset with which it is accessed, encl->nr_segments,
> is initialized before encl->segment_tbl[] and thus considered valid
> to use after the encl->segment_tbl[] check succeeds.
> 
> Fixes: 3200505d4de6 ("selftests/sgx: Create a heap for the test enclave")
> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
> ---
> Changes since V1:
> - Rewrite commit message (Dave).
> 
>   tools/testing/selftests/sgx/load.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/sgx/load.c b/tools/testing/selftests/sgx/load.c
> index 9d4322c946e2..006b464c8fc9 100644
> --- a/tools/testing/selftests/sgx/load.c
> +++ b/tools/testing/selftests/sgx/load.c
> @@ -21,7 +21,7 @@
>   
>   void encl_delete(struct encl *encl)
>   {
> -	struct encl_segment *heap_seg = &encl->segment_tbl[encl->nr_segments - 1];
> +	struct encl_segment *heap_seg;
>   
>   	if (encl->encl_base)
>   		munmap((void *)encl->encl_base, encl->encl_size);
> @@ -32,10 +32,11 @@ void encl_delete(struct encl *encl)
>   	if (encl->fd)
>   		close(encl->fd);
>   
> -	munmap(heap_seg->src, heap_seg->size);
> -
> -	if (encl->segment_tbl)
> +	if (encl->segment_tbl) {
> +		heap_seg = &encl->segment_tbl[encl->nr_segments - 1];
> +		munmap(heap_seg->src, heap_seg->size);
>   		free(encl->segment_tbl);
> +	}
>   
>   	memset(encl, 0, sizeof(*encl));
>   }
> 

The rest looks good to me. I can take this through kselftest tree, if not,

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
