Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 168B736E3BA
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Apr 2021 05:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbhD2DgE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Apr 2021 23:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbhD2DgD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Apr 2021 23:36:03 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 696C2C06138B;
        Wed, 28 Apr 2021 20:35:15 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id f12so48286910qtf.2;
        Wed, 28 Apr 2021 20:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lNUUJ8qi4DmOFV+yjdI//PoYUgIqsfa9OFzQz/+KjMI=;
        b=FmQ6jd9m7mlLLMbGjiiPmvY6WOyFJWibxvasdzl1IqeAO/eCg8/tzHc+zbBVSL+b4c
         WBpWVpbHlUythMkQWQMNezegqFJDJsd0N1YW/u4TLeC0MfEk45Sf8ymtRQ7rOl+zGMsU
         SO0WzR+SpEP3nVL47QF9uxdI++mP+wbm63SyMqIrXkru84BCtyLdoMwgDHGCCioLFFFL
         CxUwa+/Qr+F0Uh5VJdSpX0+n63pVHVrrDRN+p/oK6WlKTBFNM9Tai1FClOtuU3xdivSN
         ZfzJbWpSXGf73X0rn1iRsxCKnUOCkFDSfJFUGB0t9/N9W5Wqob4NJAKL3eROFiEbDphG
         390Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lNUUJ8qi4DmOFV+yjdI//PoYUgIqsfa9OFzQz/+KjMI=;
        b=NfAX2fNwC3QtnsAe2vUlTNcYoaeWnSCc1XlE+0HavYtaFd8+e48N2huMoKdrnJJhAQ
         trd3YncoG9dDuYnjSK1n8mkQqbkxZIr5o2U0gNdt8MOqu8dRF8tC8w3JYeWNzRl5nqPz
         aCoa77jN3X5ovjbainw0Ue/BgFq3t9H++ds9cONA/3ljleAPqO1+Tfe4wuzDB5DeZOC0
         D9BZFkJOQnw2XqMpUXP5k/1eSk2p3iDZRNUWu/ocyg/39/ccVmmhm2UuPyhEw+ypHwnF
         FaH5g7AcS5XDw0xsfEbOAjOO8+lfrOoZ112F+3UNzmmuYJ3qPohwa/jqDQY2UVYAC1Yk
         DYeA==
X-Gm-Message-State: AOAM531gYhKECC8wQle9rUV3OVoT83LG/w8mq6onQHOYyMFF1JbqQiOV
        G4xGHtogOb5LcUjnwuJjnvc=
X-Google-Smtp-Source: ABdhPJzoVnQRDl8vlJwqsbS9imdg5enRF1XkdV+pGzV3NUkBPzKbRPbb9Mic40PrfkhGrKPKQ57tcg==
X-Received: by 2002:ac8:1098:: with SMTP id a24mr28839495qtj.291.1619667314605;
        Wed, 28 Apr 2021 20:35:14 -0700 (PDT)
Received: from smtp.gmail.com ([2804:30c:909:ed00:eb66:a9ae:aa9c:152f])
        by smtp.gmail.com with ESMTPSA id m124sm1359546qkc.70.2021.04.28.20.35.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 20:35:14 -0700 (PDT)
Date:   Thu, 29 Apr 2021 00:35:10 -0300
From:   Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     kunit-dev@googlegroups.com,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        andersonreisrosa@gmail.com
Subject: Re: Running kunit_tool on unclean trees
Message-ID: <YIopbhx4YT8UZseI@smtp.gmail.com>
References: <YIRryUf6noodWiqe@smtp.gmail.com>
 <CAK7LNATsbkhYHk6NCZJCDrtT0NFfBwe_n9GRSrEvURaXaW+gfg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNATsbkhYHk6NCZJCDrtT0NFfBwe_n9GRSrEvURaXaW+gfg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 04/26, Masahiro Yamada wrote:
> On Sun, Apr 25, 2021 at 4:05 AM Marcelo Schmitt
> <marcelo.schmitt1@gmail.com> wrote:
> >
> > Hi, a friend and I were chasing bug 205219 [1] listed in Bugzilla.
> > We step into something a little bit different when trying to reproduce
> > the buggy behavior. In our try, compilation failed with a message form
> > make asking us to clean the source tree. We couldn't run kunit_tool
> > after compiling the kernel for x86, as described by Ted in the
> > discussion pointed out by the bug report.
> >
> > Steps to reproduce:
> >
> > 0) Run kunit_tool
> > $ ./tools/testing/kunit/kunit.py run
> > Works fine with a clean tree.
> >
> > 1) Compile the kernel for some architecture (we did it for x86_64).
> >
> > 2) Run kunit_tool again
> > $ ./tools/testing/kunit/kunit.py run
> > Fails with a message form make asking us to clean the source tree.
> 
> This is probably because
> tools/testing/kunit/kunit_kernel.py
> runs make with O= option.
> 
> 
> 
> > Removing the clean source tree check from the top-level Makefile gives
> > us a similar error to what was described in the bug report. We see that
> > after running `git clean -fdx` kunit_tool runs nicely again. However,
> > this is not a real solution since some kernel binaries are erased by git.
> >
> > We also had a look into the commit messages of Masahiro Yamada but
> > couldn't quite grasp why the check for the tree to be clean was added.
> > We could invest more time in this issue but actually don't know how to
> > proceed. We'd be glad to receive any comment about it. We could also try
> > something else if it's a too hard issue for beginners.
> 
> I think you are talking about the following error message.
> 
> ***
> *** The source tree is not clean, please run 'make mrproper'
> *** in /home/masahiro/ref/linux
> ***
> 

Yes, I wanted to mean that message.

> 
> 
> Kbuild checks if the source tree is clean
> before starting the out-of-tree build
> because the out-of-tree build relies on VPATH.
> 
> This check has existed for a long time. (at least more than a decade)
> 
> If Kbuild started the O= build with a dirty source tree,
> some stale generated source files would have been remaining.
> (some *.c and *.h are generated by scripts)
> 
> Then, Kbuild would wrongly use stale source files in srctree
> instead of generating new ones in objtree.
> 

I see, we better try not to break stuff.
Well, I can't think of any means of fixing bug 205219 so we're probably
going to start looking forward to work on fixes for another one.


Thanks,

Marcelo

> 
> 
> 
> 
> > [1]: https://bugzilla.kernel.org/show_bug.cgi?id=205219
> >
> >
> > Best Regards,
> >
> > Marcelo
> 
> 
> 
> --
> Best Regards
> Masahiro Yamada
> 
> -- 
> You received this message because you are subscribed to the Google Groups "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/CAK7LNATsbkhYHk6NCZJCDrtT0NFfBwe_n9GRSrEvURaXaW%2Bgfg%40mail.gmail.com.
