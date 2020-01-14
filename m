Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75294139F5C
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2020 03:13:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729099AbgANCNv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Jan 2020 21:13:51 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:35764 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728897AbgANCNv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Jan 2020 21:13:51 -0500
Received: by mail-pj1-f68.google.com with SMTP id s7so5140189pjc.0
        for <linux-kselftest@vger.kernel.org>; Mon, 13 Jan 2020 18:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+z8kiB27wPGXn90Jifmc7GvqCcTTfQFQ09TVSilQ62U=;
        b=nz5AooyyO8UV4W2raMKoiKBMXtT/bo9PatBrL5aEBihU5Bu8dzhJ8lIyBnJQ+7UN76
         P+8/m5ClVTYTjII38MEWxWvX3IgSd4aJJ5WHnTZBjPegsX3qCbvmzuugoTbHeCGxKb4D
         x4Tz6JqgNPET3RWsCkuix5TjP3xnI2zk1U5FIhqepS7I66Q5kXX0uOyeIxJgvG80qeSF
         xxacbzLRmtPQRQNpVGry/ia8R+OdKCBfLrFLnw5bvA0fTBwrEhvK38+x3T07HMggXDyN
         L3ZMnfshrU53TdeSuwwYqAH4t9yzn8peHp4uA1EZQ7oD09Aj36dwrTV0bi7V3NhYvo8o
         1BBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+z8kiB27wPGXn90Jifmc7GvqCcTTfQFQ09TVSilQ62U=;
        b=Syp4dxyosBce79SFa+cY2ccqfKCM1IlWlh8Wwyuh1R9pPLELyXrOvEBRC4olTcZGCr
         SHtrKpiGthtWUXNyyBeKzQxQeImbTvCzIE/msv0hhNIg0p8wsL0MgDHRRuU0jNU7DDML
         mFLXBh6bYCO6sYxsiJ68wSqFTO02YlqE2BJklIhMH5QeL6ZLMfvtfCCpwV0+XexnoptR
         mlbIjVHmsZ4TkIbGFmrg6JBMdXN/QLMoFGXlLMA2pm9js0B6WAmEL28msIpu66PbiNB7
         WRZMXcoGviu9XaptAQOA9oj3o7OmxBI+wXHG5x1UAdzCuDhmCptOEfijmgvOVLjkfuuI
         8Myw==
X-Gm-Message-State: APjAAAXjkQI1poi/NIw8plsC1YsCHKKGoM/lIdzWGll/bY7uZc7I3jkT
        kwIl4UQrikk0FcTeW5KUJJHbddMjir2d2YwNHlU/cQ==
X-Google-Smtp-Source: APXvYqw6inDyeiXLNEF5jBW5S399bu/qD+aslWeemGXOynwxYjD/Q4CHQwEuQJmIYgaJouVkAD9Go4Az+fNFNcXaWa0=
X-Received: by 2002:a17:902:fe8d:: with SMTP id x13mr17781759plm.232.1578968030398;
 Mon, 13 Jan 2020 18:13:50 -0800 (PST)
MIME-Version: 1.0
References: <20200110134337.1752000-1-arnd@arndb.de> <CAFd5g47+_oyqsS0o0kQ+CaLNtjqbvOmQc-n0Ch1jAT6P6RSFiw@mail.gmail.com>
In-Reply-To: <CAFd5g47+_oyqsS0o0kQ+CaLNtjqbvOmQc-n0Ch1jAT6P6RSFiw@mail.gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 13 Jan 2020 18:13:39 -0800
Message-ID: <CAFd5g45bsH1781stRRWR45AN92=o9MeafHDjt7qZQveJSVMOJQ@mail.gmail.com>
Subject: Re: [PATCH] [RFC] kunit: move binary assertion out of line
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jan 13, 2020 at 6:12 PM Brendan Higgins
<brendanhiggins@google.com> wrote:
>
> On Fri, Jan 10, 2020 at 5:43 AM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > In combination with the structleak gcc plugin, kunit can lead to excessive
> > stack usage when each assertion adds another structure to the stack from
> > of the calling function:
> >
> > base/test/property-entry-test.c:99:1: error: the frame size of 3032 bytes is larger than 2048 bytes [-Werror=frame-larger-than=]
> >
> > As most assertions are binary, change those over to a direct function
> > call that does not have this problem.  This can probably be improved
> > further, I just went for a straightforward conversion, but a function
> > call with 12 fixed arguments plus varargs it not great either.
>
> Yeah, I am not exactly excited by maintaining such a set of functions.
>
> I don't think anyone wants to go with the heap allocation route.
>
> Along the lines of the union/single copy idea[1]. What if we just put
> a union of all the assertion types in the kunit struct? One is already
> allocated for every test case and we only need one assertion object
> for each test case at a time, so I imagine that sould work.
>
> I will start messing around with the idea. Still, it sounds like we
> are down to either reducing the number of instances of this struct
> that get created per test case, or we need to remove it entirely (as
> you have done here).
>
> Cheers

Woops forgot to link the original discussion.

[1] https://lkml.org/lkml/2020/1/13/1166
