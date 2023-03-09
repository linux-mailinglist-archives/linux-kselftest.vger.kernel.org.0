Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5C446B1782
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Mar 2023 01:05:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbjCIAFt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Mar 2023 19:05:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbjCIAF0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Mar 2023 19:05:26 -0500
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA95ECCE93
        for <linux-kselftest@vger.kernel.org>; Wed,  8 Mar 2023 16:03:51 -0800 (PST)
Received: by mail-pj1-f42.google.com with SMTP id y2so505455pjg.3
        for <linux-kselftest@vger.kernel.org>; Wed, 08 Mar 2023 16:03:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678320108;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nTISrXpO300lpFWqqY1St1bGS5UZ70h7TsS28CdZuhA=;
        b=OSHH/be/3Um8HQAHWPBTdCCQkmWHtcATgC8xhii7OXWNi7XnAxDWlso2vnezj1oCRR
         5suxGvWvoS/Q68mCSQJ3vvc93sSz0jPiiYonwvsevz4GN0DlS4rpvw4AHXClpVG5f5RS
         YspWn/WIXzmuMTSuJ5mnrymiR8ukn/CimiMBc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678320108;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nTISrXpO300lpFWqqY1St1bGS5UZ70h7TsS28CdZuhA=;
        b=sHHx6pSf5De8wCtRFMtBhsdOadw3T5avAOnj5nuZJH+zRwdhLjxtuRAYsbHY2goNd1
         Ho7F1KQO7jub3E9db30b1/GC57FoXh8u/5GnJpalxAGgofQq3tOcRTyxKZdbHPcWO2hq
         RCDw6k2cZ7maWtpp6QW++VJ2m+K5yhZE1XuLgloqGB7WxNzGwDm6OGfOU45ccz3Ttk3O
         vt0J1C1cjUMUHgrOGg/ptrY5V0qtfks666dPGzgDW2BPik7Mh2huJ27eTo++93a7QTSo
         amK1khOgazAzwUJst+UCyJ33Ff+1iuFKWI863HTkkzo4huaFg9n+LWQOOZ0cs9CtDYWd
         I0XQ==
X-Gm-Message-State: AO0yUKWVg9alpr0f7e62ULBpy4nwVURjXru9ZHwoZbv/kH54SSZ//MiO
        7h5g4G7jkQcEQp6Hcdzz1MhkBg==
X-Google-Smtp-Source: AK7set8ApWx6kr+SfAyfzkE3zoJmXnq6ygcwKo6GPYa61JZgMWxU/LDFmiGNI9zIm/KYlrc1vCUDPA==
X-Received: by 2002:a17:903:18d:b0:19a:eb93:6165 with SMTP id z13-20020a170903018d00b0019aeb936165mr27011036plg.22.1678320108014;
        Wed, 08 Mar 2023 16:01:48 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id t18-20020a170902d21200b00185402cfedesm10299288ply.246.2023.03.08.16.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 16:01:47 -0800 (PST)
Message-ID: <640921eb.170a0220.28e72.38c8@mx.google.com>
X-Google-Original-Message-ID: <202303081601.@keescook>
Date:   Wed, 8 Mar 2023 16:01:46 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Shuah Khan <shuah@kernel.org>,
        Linux Kernel Functional Testing <lkft@linaro.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        KERNEL SELFTEST FRAMEWORK <linux-kselftest@vger.kernel.org>,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        lkft-triage@lists.linaro.org, Thomas Gleixner <tglx@linutronix.de>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Len Brown <len.brown@intel.com>, Borislav Petkov <bp@suse.de>,
        Stas Sergeev <stsp@list.ru>, Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>,
        Andy Lutomirski <luto@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>, llvm@lists.linux.dev
Subject: Re: [PATCH] selftests: sigaltstack: fix -Wuninitialized
References: <20230308195933.806917-1-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230308195933.806917-1-ndesaulniers@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Mar 08, 2023 at 11:59:33AM -0800, Nick Desaulniers wrote:
> Building sigaltstack with clang via:
> $ ARCH=x86 make LLVM=1 -C tools/testing/selftests/sigaltstack/
> 
> produces the following warning:
>   warning: variable 'sp' is uninitialized when used here [-Wuninitialized]
>   if (sp < (unsigned long)sstack ||
>       ^~
> 
> Clang expects these to be declared at global scope; we've fixed this in
> the kernel proper by using the macro `current_stack_pointer`. This is
> defined in different headers for different target architectures, so just
> create a new header that defines the arch-specific register names for
> the stack pointer register, and define it for more targets (at least the
> ones that support current_stack_pointer/ARCH_HAS_CURRENT_STACK_POINTER).
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Link: https://lore.kernel.org/lkml/CA+G9fYsi3OOu7yCsMutpzKDnBMAzJBCPimBp86LhGBa0eCnEpA@mail.gmail.com/
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

Looks good!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
