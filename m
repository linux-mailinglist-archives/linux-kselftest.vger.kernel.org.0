Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 355254E7D9B
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Mar 2022 01:22:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231845AbiCYTwm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Mar 2022 15:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231843AbiCYTwa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Mar 2022 15:52:30 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D71A41B0BCD
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Mar 2022 12:38:30 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id c23so10071396ioi.4
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Mar 2022 12:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=B1H5Bn5zB+2EQAYZDW062F7qRVzIqQ3ckJZTUfKRN5g=;
        b=chk0CiCTbcE4uO7RQ1G59TqpKWpIxHG6DIR9pjQFpI/etF9j+l/CP1JFnCw+kk/Wq/
         gdTvnNfq9k0g6yeFoOJ+0gFJrlOVUcGuKUb8fWAbJznpo5nEZFK+zywQuEHR4UKQhSJm
         eCvNqrThL/5nLYerLn7wd5lPJ6RHC+fHrhYEg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=B1H5Bn5zB+2EQAYZDW062F7qRVzIqQ3ckJZTUfKRN5g=;
        b=zesqSpL/2lyiEw8dhCVyubsnalXjoHWtLRQFt81slvRphvvLo7LhElXLB5XxetwrN/
         4Xq28AAuj7R1389aQyxx9kImX6n6S/9IgbQTcc6dissnZ4xS7jXCs91C7sC1UcAeiVmn
         F9+1KGTasaqdURWUiI9r+KnpLJZ09mcQtIh683Vn2Ah/Cke3UokdP/VXnIqHRf+VCOPF
         PA4VqVJj5oxR3/f6XpneCkGsVm+JPZjnuCE6vZHVv2rtLS8l0bUu8OA7tmBt2YxxabJ8
         j656osafBXfupLDk1yodYMgPVpXYrnDtO4g1zigG79Bd3tB4KNoVZsHCWezGhx7UzPqJ
         tl9Q==
X-Gm-Message-State: AOAM5315R4+6EWRMSZGd7PxHIYHTXSz9cJ58FyrJ4O80FYkmIJkad6y4
        jXoeIHcM7RxFehngmU2g7D3anw==
X-Google-Smtp-Source: ABdhPJywFUvntSkZpaimF0xybFkRMJr+LY8cOt53D5SrLtG0eK5pUM6VVXw1uoYMUd+z/F98LcRAcw==
X-Received: by 2002:a02:cb0e:0:b0:321:34d7:a47f with SMTP id j14-20020a02cb0e000000b0032134d7a47fmr6839149jap.50.1648237110269;
        Fri, 25 Mar 2022 12:38:30 -0700 (PDT)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id m8-20020a92d708000000b002c6381d9144sm3327088iln.59.2022.03.25.12.38.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Mar 2022 12:38:30 -0700 (PDT)
Subject: Re: [PATCH 2/2] selftests/harness: Pass variant to teardown
To:     Kees Cook <keescook@chromium.org>, shuah@kernel.org
Cc:     Willem de Bruijn <willemb@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-hardening@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220324231907.1363887-1-keescook@chromium.org>
 <20220324231907.1363887-3-keescook@chromium.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <d333a8d2-9100-4dc5-8780-1f96106da187@linuxfoundation.org>
Date:   Fri, 25 Mar 2022 13:38:29 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220324231907.1363887-3-keescook@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 3/24/22 5:19 PM, Kees Cook wrote:
> From: Willem de Bruijn <willemb@google.com>
> 
> FIXTURE_VARIANT data is passed to FIXTURE_SETUP and TEST_F as "variant".
> 
> In some cases, the variant will change the setup, such that expectations
> also change on teardown. Also pass variant to FIXTURE_TEARDOWN.
> 
> The new FIXTURE_TEARDOWN logic is identical to that in FIXTURE_SETUP,
> right above.
> 
> Signed-off-by: Willem de Bruijn <willemb@google.com>
> Reviewed-by: Jakub Kicinski <kuba@kernel.org>
> Acked-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> Link: https://lore.kernel.org/r/20201210231010.420298-1-willemdebruijn.kernel@gmail.com
> ---
>   tools/testing/selftests/kselftest_harness.h | 12 +++++++-----
>   1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
> index bef08f824eb5..f5cb5fd1d974 100644
> --- a/tools/testing/selftests/kselftest_harness.h
> +++ b/tools/testing/selftests/kselftest_harness.h
> @@ -291,7 +291,9 @@
>   #define FIXTURE_TEARDOWN(fixture_name) \
>   	void fixture_name##_teardown( \
>   		struct __test_metadata __attribute__((unused)) *_metadata, \
> -		FIXTURE_DATA(fixture_name) __attribute__((unused)) *self)
> +		FIXTURE_DATA(fixture_name) __attribute__((unused)) *self, \
> +		const FIXTURE_VARIANT(fixture_name) \
> +			__attribute__((unused)) *variant)
>   
>   /**
>    * FIXTURE_VARIANT() - Optionally called once per fixture
> @@ -306,9 +308,9 @@
>    *       ...
>    *     };
>    *
> - * Defines type of constant parameters provided to FIXTURE_SETUP() and TEST_F()
> - * as *variant*. Variants allow the same tests to be run with different
> - * arguments.
> + * Defines type of constant parameters provided to FIXTURE_SETUP(), TEST_F() and
> + * FIXTURE_TEARDOWN as *variant*. Variants allow the same tests to be run with
> + * different arguments.
>    */
>   #define FIXTURE_VARIANT(fixture_name) struct _fixture_variant_##fixture_name
>   
> @@ -391,7 +393,7 @@
>   			fixture_name##_##test_name(_metadata, &self, variant->data); \
>   		} \
>   		if (_metadata->setup_completed) \
> -			fixture_name##_teardown(_metadata, &self); \
> +			fixture_name##_teardown(_metadata, &self, variant->data); \
>   		__test_check_assert(_metadata); \
>   	} \
>   	static struct __test_metadata \
> 

Looks good to me.

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

