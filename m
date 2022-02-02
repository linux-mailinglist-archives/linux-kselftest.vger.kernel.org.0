Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64B434A7775
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Feb 2022 19:05:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346420AbiBBSEk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Feb 2022 13:04:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244927AbiBBSEk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Feb 2022 13:04:40 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38B59C061714
        for <linux-kselftest@vger.kernel.org>; Wed,  2 Feb 2022 10:04:40 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id q204so55266iod.8
        for <linux-kselftest@vger.kernel.org>; Wed, 02 Feb 2022 10:04:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=c0JEtni+MDhJCxKTxYFonasXrWHhXi3K1Hd10rK0nd0=;
        b=cTEH45eH2RoxkO0HD4GKL0atJHjQB7ZMmWHpkOG0QfoV9waAeZ5+hmzjhlQBPHy/D8
         iyDP7jtzECMfuwZwduEt8NCgULHGU5uWeZ/+0EBvdlUbOnxpzb+htfT2Ojxas8iAZaKW
         V49HTXWQxEcn+rMUVGvW/WoCNtRRmqY/SUIec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=c0JEtni+MDhJCxKTxYFonasXrWHhXi3K1Hd10rK0nd0=;
        b=TW2dauQbIkbGxVqd4/mkiV9jLRJdS9oum3+dTXYUA4eYlKMqHnEZAWbgqW0Gj+Eh3L
         Nvi0bhJcgZj/PecKGLvc8ZmuQAEN7h5hbwsqpducWTsncHwjkiErPn+qBm5rCMLxKW0q
         HZ0Vqnc6x4AohMYtXSLC0SQ9cqw+rbuf8FTrko/zbC8Uq5Di9nf/oLHz6S6bj1aKmtfh
         7NwX2uy/TdfTxET4/GLD8KRuLRbg2nQA/CZvKzUNoC8mkzdsT8TEU6OEQyLqd0VTlm4N
         Tc2qoGXApXuBDkTbKLgbrF8u9inRui48Smb5BsaGKvKZstqVO8Hjab4OSU6GB23fUGic
         osLQ==
X-Gm-Message-State: AOAM531N8tQF0dOsvPgMEfxJmTJhs3qp0ULNnWa7nTWdjeq5yqyplxu7
        BmxLuEyM8kA1RR5dHs+PUF8Nbg==
X-Google-Smtp-Source: ABdhPJy1ONdqSlRMRKB8s3INeUzv4z2Hx0qs271RqyFJWpVZxrOQfMd/+1/jZrY6BCtbanzSKd8aOg==
X-Received: by 2002:a05:6602:29d0:: with SMTP id z16mr16408447ioq.122.1643825079672;
        Wed, 02 Feb 2022 10:04:39 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id y4sm21041267ili.26.2022.02.02.10.04.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Feb 2022 10:04:39 -0800 (PST)
Subject: Re: [PATCH V2 4/4] selftests/sgx: Remove extra newlines in test
 output
To:     Reinette Chatre <reinette.chatre@intel.com>, jarkko@kernel.org,
        dave.hansen@linux.intel.com, linux-sgx@vger.kernel.org,
        shuah@kernel.org
Cc:     linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <cover.1643754040.git.reinette.chatre@intel.com>
 <16317683a1822bbd44ab3ca48b60a9a217ac24de.1643754040.git.reinette.chatre@intel.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <5cea376e-7e80-8105-f81d-4738c737ad75@linuxfoundation.org>
Date:   Wed, 2 Feb 2022 11:04:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <16317683a1822bbd44ab3ca48b60a9a217ac24de.1643754040.git.reinette.chatre@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/1/22 3:47 PM, Reinette Chatre wrote:
> The TH_LOG() macro is an optional debug logging function made
> available by kselftest itself. When TH_LOG_ENABLED is set it
> prints the provided message with additional information and
> formatting that already includes a newline.
> 
> Providing a newline to the message printed by TH_LOG() results
> in a double newline that produces irregular test output.
> 
> Remove the unnecessary newlines from the text provided to
> TH_LOG().
> 
> Fixes: 1b35eb719549 ("selftests/sgx: Encpsulate the test enclave creation")
> Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
> ---
> Changes since V1:
> - Add Acked-by from Dave.
> 
>   tools/testing/selftests/sgx/main.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/sgx/main.c b/tools/testing/selftests/sgx/main.c
> index b0bd95a4730d..dd74fa42302e 100644
> --- a/tools/testing/selftests/sgx/main.c
> +++ b/tools/testing/selftests/sgx/main.c
> @@ -146,7 +146,7 @@ static bool setup_test_encl(unsigned long heap_size, struct encl *encl,
>   
>   	if (!encl_load("test_encl.elf", encl, heap_size)) {
>   		encl_delete(encl);
> -		TH_LOG("Failed to load the test enclave.\n");
> +		TH_LOG("Failed to load the test enclave.");
>   		return false;
>   	}
>   
> @@ -204,7 +204,7 @@ static bool setup_test_encl(unsigned long heap_size, struct encl *encl,
>   		fclose(maps_file);
>   	}
>   
> -	TH_LOG("Failed to initialize the test enclave.\n");
> +	TH_LOG("Failed to initialize the test enclave.");
>   
>   	encl_delete(encl);
>   
> 

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
