Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2F9B4A7769
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Feb 2022 19:03:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232305AbiBBSDV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Feb 2022 13:03:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232155AbiBBSDU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Feb 2022 13:03:20 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7651FC061714
        for <linux-kselftest@vger.kernel.org>; Wed,  2 Feb 2022 10:03:20 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id w7so70745ioj.5
        for <linux-kselftest@vger.kernel.org>; Wed, 02 Feb 2022 10:03:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SI1shEwOrMkmq2fon/SPYzxLuIxmD/6oDSkyJhsld/s=;
        b=VYXEdwzhlRZAhmyKOsQKpqq7IikInC9lQzt8vPumRq3SCSIS0EyKjXWyjcPOvwi7AU
         GF9ALa4xHXdpkGkkH+bBrYfZ18PhwiV3Zz807BOmVlf9+z8a6ut2/9dtgNTTLRV/7TQQ
         DQASI3+WsxjE34ZaO0IGSfVFoICsh7as7npZk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SI1shEwOrMkmq2fon/SPYzxLuIxmD/6oDSkyJhsld/s=;
        b=O6uDChqVw0qGPuz9OlhHpmpY6346SKyRKcA0woIC7mEIk9vB8UId1eVuhazjaRdEIB
         EHoBwNmqq99l3xz3r1SHcF5k2WEO6O//FfF9GbtVfS+0nKB/Xw1Yoi10R3exhyR/yTU6
         hBC5Socb5Nf09Ik0lY6hZrUI3U+S1NeNim8ADVwS2KCqqQNaFvWdjH4qdxgD5mkNXARm
         Pq/JeK+38/T9yaQcuozdLBy4mwCnoBdIZwSwe6WfTAgbtcZHVmPewbOL1sRjGTtnVkAJ
         /CJuSqq0lTk3PjOztSoiqEHw1uYmRuJ4ona6xBrPqbwr8QTk2XZjfeFvxE1WMbbQujSS
         GXFQ==
X-Gm-Message-State: AOAM532Qoy28zbS62Rv6yKxAVYtxDNIT6XvMJezjkwJMcU4LIrXW+F8t
        41UWY18EsvJJX4oXz9tpHyut5Q==
X-Google-Smtp-Source: ABdhPJzB44zSHiZP6Q5KDJoX6x/kno+8nM3uBcm6ZA4ksTVVijnP1B9QjQ3E4YJtSuBJg4PO4z7NXw==
X-Received: by 2002:a05:6638:3e8:: with SMTP id s8mr12350195jaq.284.1643824999049;
        Wed, 02 Feb 2022 10:03:19 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id a6sm2569336iow.22.2022.02.02.10.03.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Feb 2022 10:03:18 -0800 (PST)
Subject: Re: [PATCH V2 2/4] selftests/sgx: Do not attempt enclave build
 without valid enclave
To:     Reinette Chatre <reinette.chatre@intel.com>, jarkko@kernel.org,
        dave.hansen@linux.intel.com, linux-sgx@vger.kernel.org,
        shuah@kernel.org
Cc:     linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <cover.1643754040.git.reinette.chatre@intel.com>
 <4e4ea6d70c286c209964bec1e8d29ac8e692748b.1643754040.git.reinette.chatre@intel.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <f6124d90-1036-0eef-b64a-94072302dd44@linuxfoundation.org>
Date:   Wed, 2 Feb 2022 11:03:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <4e4ea6d70c286c209964bec1e8d29ac8e692748b.1643754040.git.reinette.chatre@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/1/22 3:47 PM, Reinette Chatre wrote:
> It is not possible to build an enclave if it was not possible to load
> the binary from which it should be constructed. Do not attempt
> to make further progress but instead return with failure. A
> "return false" from setup_test_encl() is expected to trip an
> ASSERT_TRUE() and abort the rest of the test.
> 
> Fixes: 1b35eb719549 ("selftests/sgx: Encpsulate the test enclave creation")
> Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
> ---
> Changes since V1:
> - Add Acked-by from Dave.
> - Detail in commit log what callers will see with this change (Dave).
> 
>   tools/testing/selftests/sgx/main.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/sgx/main.c b/tools/testing/selftests/sgx/main.c
> index 370c4995f7c4..a7cd2c3e6f7e 100644
> --- a/tools/testing/selftests/sgx/main.c
> +++ b/tools/testing/selftests/sgx/main.c
> @@ -147,6 +147,7 @@ static bool setup_test_encl(unsigned long heap_size, struct encl *encl,
>   	if (!encl_load("test_encl.elf", encl, heap_size)) {
>   		encl_delete(encl);
>   		TH_LOG("Failed to load the test enclave.\n");
> +		return false;
>   	}
>   
>   	if (!encl_measure(encl))
> 
Acked-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

