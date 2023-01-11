Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D83F2666714
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Jan 2023 00:20:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231801AbjAKXU1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 11 Jan 2023 18:20:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbjAKXU0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 11 Jan 2023 18:20:26 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7AFA3AB2D
        for <linux-kselftest@vger.kernel.org>; Wed, 11 Jan 2023 15:20:24 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id h26so8634775ila.11
        for <linux-kselftest@vger.kernel.org>; Wed, 11 Jan 2023 15:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=82kiV6CT5bY5UwtwlTr9ODnHbyHvh43Y6iajviNHDb0=;
        b=UK3+wgm0lc1kST8z65QsZby2afptNaWNJYkOuEoueXtIuX2G0iMseEJHi0TKnpIQr9
         e2j5juB2iNKYpJhoIC92JD3m9g8VASmQaBmhTBnt/btuVwsQZUrX6h6u9NgWeUQjKQ+6
         XxJuIs8E2gVmO3IdIF+mDiyJw3JH10HGhHlRc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=82kiV6CT5bY5UwtwlTr9ODnHbyHvh43Y6iajviNHDb0=;
        b=166z2nZvrzBWOFodReQF32L+zdChfyBtugnk6Y6WlFUywgWQxj6U9/WkmKufoHz5na
         DN7cr0vbObWsSoklZ+atL800ZlKoJ18zXaZTS8XstZGBChC/LqllDM42Os6k1Iob01Zd
         tHlLx9tSoJEJ6cq0fgib6uX60XB5kwOPF9mINMuOuVpPv0FrhdMNoh3ws4vJqxXrhWot
         IDzJMizpVPBzVCQdawU2KbUOSyTFkevUQoJvISlSdh2IgQ6TcKPeT4AgZRsU7j+hIgIO
         7ZStuMH6jnt+xaLL8NfjP9JB8UK4UBbh8BRXMXmEFb8MwVgFK4GDf0xATkPM38UTZ5SA
         +HdQ==
X-Gm-Message-State: AFqh2krKrvPvPhQtXFXNYEBtFKGHlOdQR7CSsKsktwAogMhn0AG2Tq9S
        6B08KKhXLS4p/uFxFB+zoxGSxA==
X-Google-Smtp-Source: AMrXdXvNBaXGvRgfW9IIO/6VMKJAaGzPIQky+h01RDjk5ybH4GNQ4PE3cOseA2+qBakv4nWCuOpSBg==
X-Received: by 2002:a92:b703:0:b0:30c:1dda:42dd with SMTP id k3-20020a92b703000000b0030c1dda42ddmr6991828ili.1.1673479223936;
        Wed, 11 Jan 2023 15:20:23 -0800 (PST)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id g20-20020a92c7d4000000b0030c661606eesm4877810ilk.63.2023.01.11.15.20.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jan 2023 15:20:23 -0800 (PST)
Message-ID: <6d3602fd-fdf8-d6f6-56f7-d70eb2d381d8@linuxfoundation.org>
Date:   Wed, 11 Jan 2023 16:20:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] kselftest: Fix error message for unconfigured LLVM builds
To:     Mark Brown <broonie@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Shuah Khan <skhan@linuxfoundation.org>
References: <20230111-kselftest-lib-clang-fix-v1-1-58ebadd0e090@kernel.org>
Content-Language: en-US
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230111-kselftest-lib-clang-fix-v1-1-58ebadd0e090@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 1/11/23 15:33, Mark Brown wrote:
> We are missing a ) when we attempt to complain about not having enough
> configuration for clang, resulting in the rather inscrutable error:
> 
> ../lib.mk:23: *** unterminated call to function 'error': missing ')'.  Stop.
> 
> Add the required ) so we print the message we were trying to print.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>   tools/testing/selftests/lib.mk | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
> index 291144c284fb..f7900e75d230 100644
> --- a/tools/testing/selftests/lib.mk
> +++ b/tools/testing/selftests/lib.mk
> @@ -20,7 +20,7 @@ CLANG_TARGET_FLAGS              := $(CLANG_TARGET_FLAGS_$(ARCH))
>   
>   ifeq ($(CROSS_COMPILE),)
>   ifeq ($(CLANG_TARGET_FLAGS),)
> -$(error Specify CROSS_COMPILE or add '--target=' option to lib.mk
> +$(error Specify CROSS_COMPILE or add '--target=' option to lib.mk)
>   else
>   CLANG_FLAGS     += --target=$(CLANG_TARGET_FLAGS)
>   endif # CLANG_TARGET_FLAGS
> 
> ---
> base-commit: b7bfaa761d760e72a969d116517eaa12e404c262
> change-id: 20230111-kselftest-lib-clang-fix-8936ba376ea1
> 
> Best regards,

Thank you. I will queue this up for the next rc.

thanks,
-- Shuah
