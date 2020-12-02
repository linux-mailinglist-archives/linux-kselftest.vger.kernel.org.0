Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C246F2CCABF
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Dec 2020 00:55:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728700AbgLBXyO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Dec 2020 18:54:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbgLBXyO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Dec 2020 18:54:14 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBB26C0613D6
        for <linux-kselftest@vger.kernel.org>; Wed,  2 Dec 2020 15:53:33 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id 131so61641pfb.9
        for <linux-kselftest@vger.kernel.org>; Wed, 02 Dec 2020 15:53:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nsQ5jLdSfQKhTpSL0ymLOmOqE37WINwXD7J/ZGWWptg=;
        b=qs68akwBxUNYen/TbMDZh6jcl2NwcHrIH2xzkxhdqFsg/hJ4YSnG8iLbR3lsnb6swr
         QctlrFJ6XpxeAkQuAZp88C7B33wUO1H1SEP2tWZWba/pkwL7i6oN6dxeLl/9KnSc741a
         ADMn5sF/tyRB1Rek4KBMXy8dPxWwfs5OqEU/A5IAq6OyikqbUvqcbgWbxfY1t2FOwRTZ
         L+bp4woIl+sWGir2meFERd5fv51DxzHOqs2jGnSW4tHsd/+yxxZWWqFY43AnQPLn8ffL
         LKYVDps4fbqyRpRSq+d7FCMszn7srSnzpa1M8vueYHsxR99nSdArZCbF/k1uLhAOlTrl
         a03g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nsQ5jLdSfQKhTpSL0ymLOmOqE37WINwXD7J/ZGWWptg=;
        b=BK5HJxFjlHjcRiPJl5pGUCox+mykTTNlYmXTLU1A8H2oc/zX6AEZoAAnGu+0Gids3z
         Of/TTfB+0DOb2tULnz9NZO1tqsdjNpGnLXqmkSMqNJmDv/XSnt/RkPleLZNY10McRM7t
         fMz0Ji0AjA1O0G8WGFy14tEDo29+uIglXAzbpPZbDqxRC1ofHXtgt1lNQgy9YNvCxm3r
         nb/t/DWMZKOlH9jeLMjnZ1dNcAshkhUez1c4UyywyQubmmXWIikfkZGnYPM6MV+6ZZiB
         FXfMKoRTUtGbTUEWzOGWZIdKfdiKMkSi6R9eHCTAqlwNGHglPSeggcPiETD2V2EzfCAX
         WlPQ==
X-Gm-Message-State: AOAM532Rdq4ZElhNNjPu6FY3neyfHx8Bc5MDYA7hRbHYJsratcrAv4gk
        dRQbdXJpxNIozypgItQGDbEh5BvMqLnoYfsQh2ISXg==
X-Google-Smtp-Source: ABdhPJw7Os4qn4J/J3GWLqnMymO8cHSVlhlFWWZdeLtouYkYU5JylntLXKfphckaST8Rr6PSSKOUCNp2HQeSyLZEF54=
X-Received: by 2002:a65:63d5:: with SMTP id n21mr637055pgv.346.1606953213234;
 Wed, 02 Dec 2020 15:53:33 -0800 (PST)
MIME-Version: 1.0
References: <20201202211542.1121189-1-axelrasmussen@google.com> <20201202230954.GB108496@xz-x1>
In-Reply-To: <20201202230954.GB108496@xz-x1>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Wed, 2 Dec 2020 15:52:56 -0800
Message-ID: <CAJHvVch2LJa57-Si2prKa-S3VUPpu3jYxW+3-+tcLMgSXkB69w@mail.gmail.com>
Subject: Re: [PATCH] userfaultfd: selftests: make __{s,u}64 format specifiers portable
To:     Peter Xu <peterx@redhat.com>
Cc:     Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joe Perches <joe@perches.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Alan Gilbert <dgilbert@redhat.com>,
        Greg Thelen <gthelen@google.com>,
        linux-kselftest@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Dec 2, 2020 at 3:10 PM Peter Xu <peterx@redhat.com> wrote:
>
> Hi, Axel,
>
> Looks mostly good to me, but a few nitpickings below.
>
> On Wed, Dec 02, 2020 at 01:15:42PM -0800, Axel Rasmussen wrote:
>
> [...]
>
> > +static void uffd_error(const char *message, __s64 code)
> > +{
> > +     fprintf(stderr, "%s: %" PRId64 "\n", message, (int64_t)code);
> > +     exit(1);
> > +}
>
> IMHO a macro that can take arbitrary parameters would be nicer, but if it
> satisfy our need, definitely ok too.
>
> [...]
>
> > @@ -340,7 +348,8 @@ static void wp_range(int ufd, __u64 start, __u64 len, bool wp)
> >       prms.mode = wp ? UFFDIO_WRITEPROTECT_MODE_WP : 0;
> >
> >       if (ioctl(ufd, UFFDIO_WRITEPROTECT, &prms)) {
> > -             fprintf(stderr, "clear WP failed for address 0x%Lx\n", start);
> > +             fprintf(stderr, "clear WP failed for address 0x%" PRIx64 "\n",
> > +                     (uint64_t)start);
> >               exit(1);
>
> Is it intended to not use uffd_error() here?

Yes, this is intentional. This particular case prints the value in
hexadecimal, rather than decimal.

(Agree that uffd_error() could be made more general to cover cases
like this. I opted for the simplest thing which covers all but two
cases - this one, and one where we "return 1;" instead of "exit(1);" -
but I don't feel strongly.)

>
> >       }
> >  }
>
> [...]
>
> > @@ -979,26 +981,20 @@ static int __uffdio_zeropage(int ufd, unsigned long offset, bool retry)
> >       if (ret) {
> >               /* real retval in ufdio_zeropage.zeropage */
> >               if (has_zeropage) {
> > -                     if (uffdio_zeropage.zeropage == -EEXIST) {
> > -                             fprintf(stderr, "UFFDIO_ZEROPAGE -EEXIST\n");
> > -                             exit(1);
> > -                     } else {
> > -                             fprintf(stderr, "UFFDIO_ZEROPAGE error %Ld\n",
> > -                                     uffdio_zeropage.zeropage);
> > -                             exit(1);
> > -                     }
> > +                     uffd_error(uffdio_zeropage.zeropage == -EEXIST ?
> > +                                              "UFFDIO_ZEROPAGE -EEXIST" :
> > +                                              "UFFDIO_ZEROPAGE error",
>
> Nit: The indents here are a bit odd..

This is what clang-format yields. Are you thinking it would be better
to line everything up with the ( in uffd_error( ?

Or, perhaps this case is a good reason to make uffd_error() a variadic
macro so we can insert "-EEXIST" || "error" with a "%s".

>
> Thanks,
>
> --
> Peter Xu
>
