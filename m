Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C94C4C5255
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Feb 2022 01:00:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239737AbiBZAAe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Feb 2022 19:00:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239693AbiBZAAe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Feb 2022 19:00:34 -0500
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 980181CFA23
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Feb 2022 16:00:00 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id f2so5584819ilq.1
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Feb 2022 16:00:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ugujCcskb2T7bOFA5bnbVN0NBcapcRUHyZhHhBqvqXY=;
        b=b8P3ld0PDgHf4i3aCMJxbvtuNOGN48qXnOALgF9KRQwQ3sY6D5OfjLKAHQYg0NrVEG
         fGBI01HZZJYXimvvwWThe1L3nn05OUOYooFHUwtqMDpJEYDyc2cROIlKSUFEIZ8k4wxK
         asLWK3aDOse3uuGcbbj6k+mrt3quhhZoiUsKA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ugujCcskb2T7bOFA5bnbVN0NBcapcRUHyZhHhBqvqXY=;
        b=LUSsN4k/fnSEQeB2lQXKe4oVwirucwhKQFEuPAmfEXqNqE5VKrINDmQQ7y68r5Ii7x
         2wrMwp5Yb6Rf84wEiVsif0OwDSPhQbvuknrk6aTu7JNFC9bA1a7dQJQ3aDJfOFj9vx6F
         aYsUfN1/gbdx6PTrJ/H3VBjPhvSLeVUbxRpCl692SSj4LMs5YXXzCWVVqGgkaoDYhuWU
         5XMBPp3RvC8SviJp/Iri3BCEeuz/8PJeMc3v7mHqEFMR7o+e7AFEiwiJvjB7McKzxms+
         pjPF1frYbCLrG+0+fzDFsL5Aojh2cDwpq5Tkb5xvMllfSgLeICmXH110p2LbElCyTTIx
         xGJw==
X-Gm-Message-State: AOAM530clfAXDpzyQJOIDBSsQjAZ8NtDmnS1jGDAefosaPz4vFVBih5N
        rP5mM3p30nZhyqpmCjNuv1QXFw==
X-Google-Smtp-Source: ABdhPJwmWforBC8vtISK/So9rB+mq563DEdqr+aghfqU/fGd7aPhTtWQedUnhWCcfoMqpwxBTqBs4Q==
X-Received: by 2002:a05:6e02:214a:b0:2be:752a:1c24 with SMTP id d10-20020a056e02214a00b002be752a1c24mr8166149ilv.274.1645833599929;
        Fri, 25 Feb 2022 15:59:59 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id g24-20020a056602073800b006405890451fsm2190605iox.34.2022.02.25.15.59.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Feb 2022 15:59:59 -0800 (PST)
Subject: Re: [PATCH] kselftest: add generated objects to .gitignore
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Shuah Khan <shuah@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     kernel@collabora.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        netdev@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20220225102726.3231228-1-usama.anjum@collabora.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <f3757ff8-0078-4cf9-c0c6-95c780b90ae2@linuxfoundation.org>
Date:   Fri, 25 Feb 2022 16:59:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220225102726.3231228-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/25/22 3:27 AM, Muhammad Usama Anjum wrote:
> Add kselftests_install directory and some other files to the
> .gitignore.
> 
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
>   tools/testing/selftests/.gitignore      | 1 +
>   tools/testing/selftests/exec/.gitignore | 2 ++
>   tools/testing/selftests/kvm/.gitignore  | 1 +
>   tools/testing/selftests/net/.gitignore  | 1 +
>   4 files changed, 5 insertions(+)
> 

It is better to split these patches per test - makes it easier
to apply. Please send separate patches for each test. This patch
doesn't apply as is.

thanks,
-- Shuah
