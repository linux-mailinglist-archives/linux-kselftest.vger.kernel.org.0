Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6866F4D3A45
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Mar 2022 20:25:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237890AbiCITYG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Mar 2022 14:24:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237845AbiCITYC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Mar 2022 14:24:02 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B9E662CC
        for <linux-kselftest@vger.kernel.org>; Wed,  9 Mar 2022 11:22:38 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id mr24-20020a17090b239800b001bf0a375440so6182818pjb.4
        for <linux-kselftest@vger.kernel.org>; Wed, 09 Mar 2022 11:22:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EGDyT1tV4o9cHKMKOSJ3P2N73OyIn36r8ZT+WWtaSJM=;
        b=P3jlJdlcuRzTGM75HGWF/LMggRln9TBb5LmJMnvuIOGvG3qun+eTmyDhrv/uDFhR4x
         2rRPgGPDonzNxn9Kdz38C3xhATNJF0sWHhN17OSHklZtpgB0nyUGry6M7NH8Mz82PkWp
         PNkSZetwAWx9v8zeTEYzobhRIH0eyUHBeTkVU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EGDyT1tV4o9cHKMKOSJ3P2N73OyIn36r8ZT+WWtaSJM=;
        b=iWKBIstz4uK5FIC7Xfe7uxIbBS+e4fT9nIHbeXbU99Jid8E0149MyXb+Z2TKxvFcuF
         j39qsINnNzg/g6D5LAV6yr5PtEYlbw5T1i8tm/wtAQq8+vgagkvPaIS1a6BtwC1FNx2p
         RD7KK9IwuPcwlRr+PByrz9wD1whUSCxnx2mo/fvEfl3w+utPi/MxhtC85OT4Uw+M4eUI
         JFDAanMTFAaedmPAXdMnBAsDmxZOjPLNPm7G/zuxQZFbJdCshbb/rZc/YA31OJ7KRbyd
         0FQTzSBw682at5T94PqQ2DItZdWtGZ3kRm7LGPwWsTV+4nQowco0mEK0EyCtcKXrjZOM
         tbIw==
X-Gm-Message-State: AOAM5305NmNmnenkMCiFXJeTibJoplkZHeLpFxBK9Fjir4qPdbvHc2mH
        bLKHS3jbj7aEa8KVLgHuq0umC7dwiL2oTg==
X-Google-Smtp-Source: ABdhPJw5gr8lbO9F2RqImWEl0bBFwqjL2c9fLYlBLZjv04LnRfLSQ8pP+jqGmegKk7VNUOlTqTF6iA==
X-Received: by 2002:a17:90a:2d0:b0:1bc:4fc0:6fb7 with SMTP id d16-20020a17090a02d000b001bc4fc06fb7mr1047827pjd.196.1646853758046;
        Wed, 09 Mar 2022 11:22:38 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k19-20020a056a00135300b004f734327960sm4129111pfu.106.2022.03.09.11.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 11:22:37 -0800 (PST)
Date:   Wed, 9 Mar 2022 11:22:37 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     Shuah Khan <shuah@kernel.org>, kernel@collabora.com,
        kernelci@groups.io,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] selftests/lkdtm: add config and turn off
 CFI_FORWARD_PROTO
Message-ID: <202203091122.A51B31230A@keescook>
References: <20220217205620.2512094-1-usama.anjum@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220217205620.2512094-1-usama.anjum@collabora.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Feb 18, 2022 at 01:56:19AM +0500, Muhammad Usama Anjum wrote:
> Add config options which are needed for LKDTM sub-tests.
> STACKLEAK_ERASING test needs GCC_PLUGIN_STACKLEAK config.
> READ_AFTER_FREE and READ_BUDDY_AFTER_FREE tests need
> INIT_ON_FREE_DEFAULT_ON config.
> 
> CFI_FORWARD_PROTO always fails as there is no active CFI system of some
> kind. Turn it off for now by default until proper support.

Building under LTO Clang on arm64, this is available. What's the right
way to add a CONFIG that isn't always available?

-Kees

> 
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Fixes: 46d1a0f03d66 ("selftests/lkdtm: Add tests for LKDTM targets")
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
>  tools/testing/selftests/lkdtm/config    | 2 ++
>  tools/testing/selftests/lkdtm/tests.txt | 2 +-
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/lkdtm/config b/tools/testing/selftests/lkdtm/config
> index 46f39ee762086..adc9fa60057c5 100644
> --- a/tools/testing/selftests/lkdtm/config
> +++ b/tools/testing/selftests/lkdtm/config
> @@ -2,8 +2,10 @@ CONFIG_LKDTM=y
>  CONFIG_DEBUG_LIST=y
>  CONFIG_SLAB_FREELIST_HARDENED=y
>  CONFIG_FORTIFY_SOURCE=y
> +CONFIG_GCC_PLUGIN_STACKLEAK=y
>  CONFIG_HARDENED_USERCOPY=y
>  CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT=y
> +CONFIG_INIT_ON_FREE_DEFAULT_ON=y
>  CONFIG_INIT_ON_ALLOC_DEFAULT_ON=y
>  CONFIG_UBSAN=y
>  CONFIG_UBSAN_BOUNDS=y
> diff --git a/tools/testing/selftests/lkdtm/tests.txt b/tools/testing/selftests/lkdtm/tests.txt
> index 6b36b7f5dcf96..aa947b0ce1eeb 100644
> --- a/tools/testing/selftests/lkdtm/tests.txt
> +++ b/tools/testing/selftests/lkdtm/tests.txt
> @@ -72,7 +72,7 @@ USERCOPY_STACK_FRAME_FROM
>  USERCOPY_STACK_BEYOND
>  USERCOPY_KERNEL
>  STACKLEAK_ERASING OK: the rest of the thread stack is properly erased
> -CFI_FORWARD_PROTO
> +#CFI_FORWARD_PROTO
>  FORTIFIED_STRSCPY
>  FORTIFIED_OBJECT
>  FORTIFIED_SUBOBJECT
> -- 
> 2.30.2
> 

-- 
Kees Cook
