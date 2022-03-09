Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54DD54D3A48
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Mar 2022 20:25:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237913AbiCITZI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Mar 2022 14:25:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237948AbiCITY5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Mar 2022 14:24:57 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9180E4CD61
        for <linux-kselftest@vger.kernel.org>; Wed,  9 Mar 2022 11:23:37 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id h5so1464735plf.7
        for <linux-kselftest@vger.kernel.org>; Wed, 09 Mar 2022 11:23:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CRfO2Ur95cYH1T7zyYInkNyjF7LOYfVUKmOdK5m6fo4=;
        b=eo+ZV7IgG8oipmlrVkf+iyTgfnI2yr6eOTY+2cqs0Cnnymj5QR9/58HyPhuMaOWvVz
         T5GybQaczXCeBogbj+W6OkXhhZislKNqbbd7hBHOkCILyRdusg2lqqBQt/CHfzFHa1VX
         3F8aml9pD5RkBEkQnkGJyujePwV3Y0ubYKN3k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CRfO2Ur95cYH1T7zyYInkNyjF7LOYfVUKmOdK5m6fo4=;
        b=mS+7XueEav/9i4aYR1+QUwPX2uyjj90sC3ICUyBjQT5DMrT34eIR7bAhgJOoP5fsuJ
         kWcT7ubeG9UfTgPGewwcj5vVI2Bfl48r84oArdjRNXw/UiQNRji5ebDTCoOmWpxMiAoA
         J0A+8XsSEWhv/OgcdPs8NkLOiS1HZnAVyNWe/1NcrOuA63sAmDW8pitnv67R1TY/a5sl
         mQalZytsbzndpOPEcaOu7iQ3KlLVzAi3DXdEWm9u2jIrGk3M0peYgG+E3wNbK5E9O9dh
         fKQNZCk4ewRQVprhHaax0Wz8xdbTABFLv27dcYYY6wVpEFspSOiOHnMg3oXpoYGNue7j
         4Yqw==
X-Gm-Message-State: AOAM531mh4T7jAioSlyVGA9sagD0Dv5Yy8WgD7le/R2clu1+j9ULwiIw
        9bZGI+tKrfhMUnOagXAtqGlySY06DfbyHQ==
X-Google-Smtp-Source: ABdhPJzuoaKhZ+nLC7aSaHADhAHBM3PTsrUf2FTMjE4iFoVaufm9+Vfttgy/euDehCY12DjPFMx8qw==
X-Received: by 2002:a17:902:f785:b0:14d:d2b6:b7c with SMTP id q5-20020a170902f78500b0014dd2b60b7cmr1046035pln.68.1646853817104;
        Wed, 09 Mar 2022 11:23:37 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z23-20020a17090a609700b001bf5a1830f3sm3594359pji.10.2022.03.09.11.23.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 11:23:36 -0800 (PST)
Date:   Wed, 9 Mar 2022 11:23:36 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     Shuah Khan <shuah@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel@collabora.com, kernelci@groups.io,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] selftests/lkdtm: add config
Message-ID: <202203091123.33E89F5@keescook>
References: <20220217205620.2512094-1-usama.anjum@collabora.com>
 <20220217205620.2512094-2-usama.anjum@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220217205620.2512094-2-usama.anjum@collabora.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Feb 18, 2022 at 01:56:20AM +0500, Muhammad Usama Anjum wrote:
> Add config option which is needed for SLAB_LINEAR_OVERFLOW test. It
> needs KASAN enabled.

I'd prefer this use the SLAB_DEBUG options -- KASAN is very heavy.

-Kees

> 
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Fixes: 9c4f6ebc3665 ("lkdtm/heap: Add vmalloc linear overflow test")
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
>  tools/testing/selftests/lkdtm/config | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/lkdtm/config b/tools/testing/selftests/lkdtm/config
> index adc9fa60057c5..4e8af0f712f74 100644
> --- a/tools/testing/selftests/lkdtm/config
> +++ b/tools/testing/selftests/lkdtm/config
> @@ -7,6 +7,7 @@ CONFIG_HARDENED_USERCOPY=y
>  CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT=y
>  CONFIG_INIT_ON_FREE_DEFAULT_ON=y
>  CONFIG_INIT_ON_ALLOC_DEFAULT_ON=y
> +CONFIG_KASAN=y
>  CONFIG_UBSAN=y
>  CONFIG_UBSAN_BOUNDS=y
>  CONFIG_UBSAN_TRAP=y
> -- 
> 2.30.2
> 

-- 
Kees Cook
