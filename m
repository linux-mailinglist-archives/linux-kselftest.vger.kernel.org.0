Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 275B2503848
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 Apr 2022 23:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233052AbiDPVQC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 16 Apr 2022 17:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbiDPVQB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 16 Apr 2022 17:16:01 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD15E2E6A0
        for <linux-kselftest@vger.kernel.org>; Sat, 16 Apr 2022 14:13:26 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id md4so10163916pjb.4
        for <linux-kselftest@vger.kernel.org>; Sat, 16 Apr 2022 14:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BjuGjhP4kQ32yKxfj1klKnac9K0XU0XMV9i06nB2Ffw=;
        b=GyVgmPUPKlHwgjgMupQ3m8a1KtAcRlmYQtP+ay8ThpdC8/UZAH9YWi+a1xebtVu3z9
         3HNwQs3a8FTwoxLtDQPx4+agyG51wueyE8SZx8anisVgHgvTqPEaUV+Qa6rdUVavZg29
         CTLMxmd6i4Z7MvxuRnYfozyCe+Adzip55g/DU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BjuGjhP4kQ32yKxfj1klKnac9K0XU0XMV9i06nB2Ffw=;
        b=qAXhZ6Z5n/hiPkI+oZb3zMYM0jN6XS3jKSySSAKgyE2RcaVWw7/tc5SQ+5rQnBZRZx
         H++xgi3iZiG06aR6SUSluF3vXZfvKmrUB18jn1/C7/02aM70Zeb5yL8P3z7aRW5vWALN
         mQ0JgqNsg485nBGf1cNZu9VbNxIMbvbSDlL7YjYFRa5JjmJEd8tGnRvQPDazIH3GTY//
         8wj5Wp/IjQYZeMfV8v1HVUjktCLdKERTEYJ/bpz6sWfbBQfiXpBFmaosVOtNcKaiJc3L
         BFnECtZFOuQzjDw2oR8hW7wCfWFTrXMM5P6xs6TjfGVLit/i1Z5kj5gAZfN+NzQ4V+Dt
         9kFA==
X-Gm-Message-State: AOAM530U49Ed/ldzqKFFo8V4lDvwqTTZT9n5lo71Vko3sUBLtA3FqqgP
        sUbYGHSWyHrFgav6DZpr2IEA1w==
X-Google-Smtp-Source: ABdhPJw1Iuz9CgyW1LYrs6aaku8ERT5AYV8PDxCcP+HhoQjHs7Ts0OOOvQ9hwQ3C8FVMgtJHM26JRA==
X-Received: by 2002:a17:902:b582:b0:14c:a63d:3df6 with SMTP id a2-20020a170902b58200b0014ca63d3df6mr4610655pls.51.1650143606310;
        Sat, 16 Apr 2022 14:13:26 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f187-20020a6251c4000000b005058e59604csm6758560pfb.217.2022.04.16.14.13.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Apr 2022 14:13:25 -0700 (PDT)
Date:   Sat, 16 Apr 2022 14:13:25 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     Shuah Khan <shuah@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel@collabora.com, kernelci@groups.io,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] selftests/lkdtm: add config
Message-ID: <202204161407.D6D3202FD@keescook>
References: <20220217205620.2512094-1-usama.anjum@collabora.com>
 <20220217205620.2512094-2-usama.anjum@collabora.com>
 <202203091123.33E89F5@keescook>
 <76529762-1a36-142d-0aa9-beb5fa2bb27b@collabora.com>
 <aaeaefb7-3655-2863-46ae-162bf5ab761c@collabora.com>
 <a9c74cc2-491e-678a-8965-86fa6a6002dc@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9c74cc2-491e-678a-8965-86fa6a6002dc@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Apr 04, 2022 at 12:50:01PM +0500, Muhammad Usama Anjum wrote:
> Hi Kees,
> 
> Any thoughts?
> 
> On 3/15/22 4:55 PM, Muhammad Usama Anjum wrote:
> > On 3/10/22 10:22 PM, Muhammad Usama Anjum wrote:
> >> On 3/10/22 12:23 AM, Kees Cook wrote:
> >>> On Fri, Feb 18, 2022 at 01:56:20AM +0500, Muhammad Usama Anjum wrote:
> >>>> Add config option which is needed for SLAB_LINEAR_OVERFLOW test. It
> >>>> needs KASAN enabled.
> >>>
> >>> I'd prefer this use the SLAB_DEBUG options -- KASAN is very heavy.
> >> I'll test it out and update in the next patch version.
> >> I've tested by removing KASAN and adding the following config:
> > CONFIG_SLAB=y
> > CONFIG_DEBUG_SLAB=y

I recommend slub instead:

CONFIG_SLUB=y
CONFIG_SLUB_DEBUG=y

and one more, see below...

> > 
> > The result of SLAB_LINEAR_OVERFLOW test doesn't remain deterministic in
> > this config. The task never crashes and hence stack trace never appears.
> > When executed several times we get "Slab corruption" logs and after some
> > more tries whole kernel crashes. I've not used DEBUG_SLAB before and not
> > sure if this is the expected behavior. If we aren't sure, we can keep
> > KASAN turned on instead.

I think you need to enable the actual kmem debugging with a boot param
("slub_debug=ZF"), or with CONFIG_SLUB_DEBUG_ON=y.

-- 
Kees Cook
