Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CBA768362C
	for <lists+linux-kselftest@lfdr.de>; Tue, 31 Jan 2023 20:11:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbjAaTLW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 31 Jan 2023 14:11:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbjAaTLU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 31 Jan 2023 14:11:20 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A83F059B65
        for <linux-kselftest@vger.kernel.org>; Tue, 31 Jan 2023 11:10:59 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id t18so15219295wro.1
        for <linux-kselftest@vger.kernel.org>; Tue, 31 Jan 2023 11:10:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LWQaPUHdvnU65mQKid3pXmNQLFqWKjlrZ1lOgMgLH+s=;
        b=KRhy5frvJMVHgXhqQrlHounxae4upCd0hrESJBpOq5WU1qL7Uzbhat0uhXVNpYQhTz
         b9qVSdLZ7CueM1UBOwhymX1jMWKQRypoS5c49CeHKgAAs0dE/qDA2mMfiuYW7kV7eqws
         ZKoyZjP0TA6ytqwMBYJJowiBgQrWiNRHmF+5aVU9vCeaXd1WYmsLVZAoKeT83z4U0lHX
         cWCyQO8vleafzBGlRQE+ooU7gCuD8T/cDGFxZizak+VXnZ6mQLG4TZUMrXCnh3rJFxaW
         kx7wJk4eKPBG5/kU4Qj+wA0ZtXg4vcfuLvbKiOeskhSuOjFGtXbeAxc6Rj7ywThFIYOE
         7AQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LWQaPUHdvnU65mQKid3pXmNQLFqWKjlrZ1lOgMgLH+s=;
        b=Al36HBQiGbr1FlDbWOpj1MVyxOxijsmq1iVBMDOHgEXWOfzxejrfVjoCplmyQdJ6KJ
         niTuB/c21RU9SqTo7eEfjtZwYj7OlYNx25QHDI1r3OT9VqezxuFv2YvWQyGrEKBNz1jC
         UU5hRF7VbMYDb9Ju1g5JQd2MR/3pr2POg/q/3nOASGIR2sXZl3uDyuIrOFgUDb2idT3l
         c7CTAXBxS5ZQiqnV5TrX8mdNLmzZj2Rgzvk1NgxuyVvQF+YJqS8KdBhB79MyYsXYGCxg
         rnDhu28zuMnLaccc2CatDYC1pVmGE42omPg57IYWPT0WCr1aswbqjos4Z2Vv+eMv6wA+
         RvDQ==
X-Gm-Message-State: AO0yUKXZC/9+zkHLoZiCjR5y4m69ZiOkaEOUz0ByMXuKHRhDiX6uYNxz
        NdY35TM+B1tmuPCiulOC9cACwA==
X-Google-Smtp-Source: AK7set8y+W5CT0CBXGADEv6jw70U8BiynRGR11vPErBj7/6RMyebIrDMuBfwqBhI7I+SzvnxeImg9A==
X-Received: by 2002:a5d:6b89:0:b0:2bf:b571:1f18 with SMTP id n9-20020a5d6b89000000b002bfb5711f18mr74635wrx.61.1675192255852;
        Tue, 31 Jan 2023 11:10:55 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id j9-20020a5d6189000000b002c285b4d2b5sm2516469wru.101.2023.01.31.11.10.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Jan 2023 11:10:55 -0800 (PST)
Message-ID: <ce9eb95b-bff6-c042-efbc-b42062d7cbf2@linaro.org>
Date:   Tue, 31 Jan 2023 20:10:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] .gitignore: Keep track of archived files as they are
 added to a new git repo
Content-Language: en-US
To:     Like Xu <like.xu.linux@gmail.com>, Will Deacon <will@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Shuah Khan <shuah@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Kees Cook <keescook@chromium.org>, Andrew Davis <afd@ti.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, kvm@vger.kernel.org
References: <20230130090426.13864-1-likexu@tencent.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230130090426.13864-1-likexu@tencent.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 30/01/2023 10:04, Like Xu wrote:
> From: Like Xu <likexu@tencent.com>
> 
> With thousands of commits going into mainline each development cycle,
> the metadata .git folder size is gradually expanding (1GB+), and for some
> developers (most likely testers) who don't care about the lengthy git-log,
> they just use git-archive to distribute a certain version of code (~210MB)
> and rebuild git repository from anywhere for further code changes, e.g.
> 
>   $ git init && git add . -A
> 
> Then unfortunately, the file tracking metadata from the original git-repo
> using "git add -f" will also be lost, to the point where part of source
> files wrapped by git-archive may be accidentally cleaned up:
> 
>   $ git clean -nxdf
>   Would remove Documentation/devicetree/bindings/.yamllint

https://lore.kernel.org/all/20230127150225.18148-1-andriy.shevchenko@linux.intel.com/

Best regards,
Krzysztof

