Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFA1A4CDBCF
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Mar 2022 19:09:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233533AbiCDSJx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Mar 2022 13:09:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241483AbiCDSJx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Mar 2022 13:09:53 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B051C1C60F3
        for <linux-kselftest@vger.kernel.org>; Fri,  4 Mar 2022 10:09:04 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id a5so8234030pfv.9
        for <linux-kselftest@vger.kernel.org>; Fri, 04 Mar 2022 10:09:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yqxK85bZK7xDyQw2uCXi3loaqdFYPJjcAinZfxqk6do=;
        b=ocz1+Iw2gQLaJb2kUh6BCjlQE8FtpZ7onQytZBB4oTiku41XTQb2azH+A6m4FymENh
         NAhz4xCeV1dpJWdXtIOLKucZqrbpLU3XDDZnZu/knH/ZFLtyGFMioPHgUmN5h2xuI5s6
         CMoiAVi/wR7mULEHHgmDBVlensKUZylG60Y1U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yqxK85bZK7xDyQw2uCXi3loaqdFYPJjcAinZfxqk6do=;
        b=A3g+HILHiZyUBKxNDFKCu6CkiUhelrwzqnfK2s+V7Zav+uaTDZykDzm5SpIk111RRO
         ppOSNHoSsjo9FTvTbKK7ZK8MN6e6Ezk+E2fTaMGsASZV9WWUTJZjGcSRS5J9s7s0V48+
         mz1LxEkxVTG5vu06p0PlOIIEW3bjLz6eZSpvAXuIayIRF4Jq4Kc5IxM9rY11CUk6Eblw
         eNW7HhHgv0jdjH2QXnflc5dqNGyknudj+0cGttsXyPDC6qahmd1dKvPY19jGsypx2m+R
         puJl9HJBrdkZcgXmbe2/UMdlVhtcdAf0stH/Y9qZoklQGt7m2L7iNF2VmZCtdmviw4/m
         Hoxw==
X-Gm-Message-State: AOAM531jStzbH3H1RyIAQ37NH2m+4xNdLKmK9SIzsP+KrdGv1/XTxvZn
        MfTNSALQNSGxL7Zf3OwfIjILUA==
X-Google-Smtp-Source: ABdhPJx0NCCGjOT8EpZGR6/1/fL3PG5CbdMIqYeA3vaoHL7EPfBcyJQ0doJAvVQog4jtN8Af1IBekQ==
X-Received: by 2002:a05:6a00:1312:b0:4e1:58c4:ddfd with SMTP id j18-20020a056a00131200b004e158c4ddfdmr44651556pfu.65.1646417344203;
        Fri, 04 Mar 2022 10:09:04 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n18-20020a056a00213200b004e17d967d13sm6276262pfj.124.2022.03.04.10.09.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 10:09:03 -0800 (PST)
Date:   Fri, 4 Mar 2022 10:09:03 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Shuah Khan <shuah@kernel.org>, llvm@lists.linux.dev,
        linux-kbuild@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2] kbuild: Make $(LLVM) more flexible
Message-ID: <202203041005.A3B985C@keescook>
References: <20220304170813.1689186-1-nathan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220304170813.1689186-1-nathan@kernel.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Mar 04, 2022 at 10:08:14AM -0700, Nathan Chancellor wrote:
> [...]
> 
> Update and reorder the documentation to reflect these new additions.
> At the same time, notate that LLVM=0 is not the same as just omitting it
> altogether, which has confused people in the past.

Is it worth making LLVM=0 actually act the way it's expected to?

> Link: https://lore.kernel.org/r/20200317215515.226917-1-ndesaulniers@google.com/
> Link: https://lore.kernel.org/r/20220224151322.072632223@infradead.org/
> Suggested-by: Masahiro Yamada <masahiroy@kernel.org>
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Looks good; minor .rst nit below...

Reviewed-by: Kees Cook <keescook@chromium.org>

> [...]
> -LLVM has substitutes for GNU binutils utilities. Kbuild supports ``LLVM=1``
> -to enable them. ::
> -
> -	make LLVM=1
> -
> -They can be enabled individually. The full list of the parameters: ::
> +LLVM has substitutes for GNU binutils utilities. They can be enabled individually.
> +The full list of supported make variables: ::

": ::" and "::" yield the same result. I think the latter is more
readable in non-rendered form. *shrug*

-Kees

-- 
Kees Cook
