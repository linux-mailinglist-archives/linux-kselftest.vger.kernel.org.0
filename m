Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD6D206811
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jun 2020 01:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387829AbgFWXKa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 23 Jun 2020 19:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387848AbgFWXK1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 23 Jun 2020 19:10:27 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 133BEC061573
        for <linux-kselftest@vger.kernel.org>; Tue, 23 Jun 2020 16:10:26 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id i12so159679pju.3
        for <linux-kselftest@vger.kernel.org>; Tue, 23 Jun 2020 16:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7CGyJvgDfqa7MpUh5embDkSIvDYKMmy2PpptbOHIrEM=;
        b=KbxBnfchg2RNBRCTFJcBQBqbQAmyNQh/HXi+viuVz7TZ4U9dkUGXHvTy44WpHvxokb
         87n0dBDZDidnAzVyqWRq33wij2V0sVhaVFfIaucT3qotWt3zH2jjPWJkJS2kQILaoMQL
         yRN9ZLg8FrVnGR1hLX+DaepKcjahJ0EpkhK5o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7CGyJvgDfqa7MpUh5embDkSIvDYKMmy2PpptbOHIrEM=;
        b=CBB4OEZITbZGJ1Hqdm1JH3YByJOG2UrdY2VEEo/qlOwEuI9kUXAxIHwtwq12gxpOXX
         A/lDNe0rEQzNvjRB2B0H9eFyUgAFqAchNY+kFjcOj6rvAf1XMWttxpe5LvIevEIqZ28P
         COBigke3zs/miR5+H6xUAN/6t7euSwla+C0oz2gFAmsELMBsXp0rmIhMGFmpVrE9U4Aj
         FAjpoKjpfN46tCqB4PivsZoTO81XMiOHoy5xinLVYShGzXz+cwCQ7IIXrVVMoO0BA1tR
         6IsreC0+/DFuFiJK7Aa+z3fAUjxcPERW91XjVqI/bNGs8uXrJpF8+BlINDuxWCfy7JJ9
         xTIQ==
X-Gm-Message-State: AOAM5323NC9eISw4iSL6wdOlKPJ70RJMeewSOgQanTPW8h0c/4EfVL/L
        GRcSG3InmVYckl0ZPY6vbkGqZg==
X-Google-Smtp-Source: ABdhPJxWiopvITqQoUsjOrkPVJLPViTKTyfPSXoXAyVLmwAy3lfwE9jEZ/6WkBPSzCGcW/dk/mk+LA==
X-Received: by 2002:a17:90a:d186:: with SMTP id fu6mr3871728pjb.185.1592953825608;
        Tue, 23 Jun 2020 16:10:25 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id r7sm13275139pfc.183.2020.06.23.16.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 16:10:24 -0700 (PDT)
Date:   Tue, 23 Jun 2020 16:10:23 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Prasad Sodagudi <psodagud@codeaurora.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        linux-kselftest@vger.kernel.org,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH drivers/misc 0/4] lkdtm: Various clean ups
Message-ID: <202006231610.4993DC5@keescook>
References: <20200529200347.2464284-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200529200347.2464284-1-keescook@chromium.org>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, May 29, 2020 at 01:03:43PM -0700, Kees Cook wrote:
> Hi Greg,
> 
> Can you please apply these patches to your drivers/misc tree for LKDTM?
> It's mostly a collection of fixes and improvements and tweaks to the
> selftest integration.

Friendly ping -- we're past -rc2 now. :)

Thanks!

-Kees

> 
> Thanks!
> 
> -Kees
> 
> Kees Cook (4):
>   lkdtm: Avoid more compiler optimizations for bad writes
>   lkdtm/heap: Avoid edge and middle of slabs
>   selftests/lkdtm: Reset WARN_ONCE to avoid false negatives
>   lkdtm: Make arch-specific tests always available
> 
>  drivers/misc/lkdtm/bugs.c               | 45 +++++++++++++------------
>  drivers/misc/lkdtm/heap.c               |  9 ++---
>  drivers/misc/lkdtm/lkdtm.h              |  2 --
>  drivers/misc/lkdtm/perms.c              | 22 ++++++++----
>  drivers/misc/lkdtm/usercopy.c           |  7 ++--
>  tools/testing/selftests/lkdtm/run.sh    |  6 ++++
>  tools/testing/selftests/lkdtm/tests.txt |  1 +
>  7 files changed, 56 insertions(+), 36 deletions(-)
> 
> -- 
> 2.25.1
> 

-- 
Kees Cook
