Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 253D43B1CB1
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Jun 2021 16:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231262AbhFWOka (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 23 Jun 2021 10:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbhFWOk3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 23 Jun 2021 10:40:29 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F33CC061756
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Jun 2021 07:38:12 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id bb20so1615964pjb.3
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Jun 2021 07:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gYsWzSIHMSc6Tk2EhcHMeSwtIxBEj34qEnDzw9ljN3s=;
        b=On69jlBS8D8eW015oMkd5PZ2WcwQmLiyjgNGu9DtIfKZV0aMLPx3I4ItRey5K6mYDV
         xwOnvhsLXMLHTs9uOgjKZM+AAmcRCcNUyOXkhDaasZ4vUbuQUC2Y+tJOn+sxQ6ANsmda
         fPYT2eyPvHfGHH1cz0BDu0FYRr7cNEsZ9OeAs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gYsWzSIHMSc6Tk2EhcHMeSwtIxBEj34qEnDzw9ljN3s=;
        b=Ammk28I5gNn/nUnYj7OWXIAin5/u8dZ7GhHBgw0ZVXsfbHZd5sXql7h8rWoSqhHmlc
         mSfsoLZUyG/BD7P6303pBT1T6sgJ7zDrM/D1N1cnMQlJCFRd7eY8eqkkFI5DyeZ7L3Ng
         OtJjqFS4MG4FwtQWVD892hHBv2AHWO94xGiFLYe6lIYNCBedkMa5OeUanB2dy3L/voSI
         ujLAr+K/naUKREiKvd5jd/MDF7h72itMEuF3UIeuhxEmBD/N9ibLbIQ2MhhOthA+6a3I
         8nN4Y/b3dAXZTyeKezHgFpo+vO9NSRCGNlOv9V/CRa2wB/RxO28yJauuPRJYc8gR18a3
         LtOQ==
X-Gm-Message-State: AOAM530gl5aStUcEkDR/3Pr6qeIzOKUiLMbpRiFpIvT2O4O69JNCpRy6
        PCvKL37SrC6Rmp0vvreBQcZntzkoZy2Kwc+E
X-Google-Smtp-Source: ABdhPJyPZywy459VJObSw/vvdeHF8Qv736PYSJ4zEvgpg+nRYBaYdVTNJsDR2tMXD8cxy2Ug8yvQ9w==
X-Received: by 2002:a17:902:db07:b029:125:765c:75e1 with SMTP id m7-20020a170902db07b0290125765c75e1mr9852plx.9.1624459092040;
        Wed, 23 Jun 2021 07:38:12 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i125sm186361pfc.7.2021.06.23.07.38.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 07:38:11 -0700 (PDT)
Date:   Wed, 23 Jun 2021 07:38:10 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Guillaume Tucker <guillaume.tucker@collabora.com>
Cc:     Shuah Khan <shuah@kernel.org>, stable@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] selftests/lkdtm: Use /bin/sh not $SHELL
Message-ID: <202106230734.78A239D@keescook>
References: <20210619025834.2505201-1-keescook@chromium.org>
 <e958209b-8621-57ca-01d6-2e76b05dab4c@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e958209b-8621-57ca-01d6-2e76b05dab4c@collabora.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jun 23, 2021 at 01:39:57PM +0100, Guillaume Tucker wrote:
> On 19/06/2021 03:58, Kees Cook wrote:
> > Some environments do not set $SHELL when running tests. There's no need
> > to use $SHELL here anyway, so just replace it with hard-coded path
> > instead. Additionally avoid using bash-isms in the command, so that
> > regular /bin/sh can be used.
> > 
> > Suggested-by: Guillaume Tucker <guillaume.tucker@collabora.com>
> > Fixes: 46d1a0f03d66 ("selftests/lkdtm: Add tests for LKDTM targets")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> 
> 
> Tested-by: "kernelci.org bot" <bot@kernelci.org> 
> 
> 
> Sample staging results with this patch applied on top of
> next-20210622:
> 
> https://staging.kernelci.org/test/plan/id/60d2dbdc3cfb88da0924bf41/
> 
> Full log:
> 
> https://storage.staging.kernelci.org/kernelci/staging-next/staging-next-20210623.0/x86_64/x86_64_defconfig+x86-chromebook+kselftest/clang-13/lab-collabora/kselftest-lkdtm-asus-C523NA-A20057-coral.html

Awesome! This looks great. :)

What's needed to build these kernels will different CONFIGs? I see a
bunch of things (commonly found in distro kernels) that are not set:

CONFIG_SLAB_FREELIST_HARDENED=y
CONFIG_FORTIFY_SOURCE=y
CONFIG_HARDENED_USERCOPY=y
# CONFIG_HARDENED_USERCOPY_FALLBACK is not set

Should I add these to the kselftest "config" file for LKDTM?

Thanks again for the help with this!

-Kees

-- 
Kees Cook
