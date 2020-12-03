Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31C722CCBB1
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Dec 2020 02:34:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727055AbgLCBdp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Dec 2020 20:33:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50059 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726755AbgLCBdp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Dec 2020 20:33:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606959138;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=T+i4hgnbURlmHWFQ6sHh3xD+xz+pB56D5OvWJIuIZUg=;
        b=UBIH/+ZuQ4dzQeZ9WD7xzGVMi5EQrgaHZdfkrn/c8ub5ATVLj7vaIgNPiYZYI9Xwq/x8ue
        TaPVIXIgUtjrYjqAGeM1fpbTQY83U6nkb/b90ksZ/Eby/DnVeSdoJNUXHT2sAvD8YsmFbo
        q4hMT5QC2TmoTmb9SGEhycNJVcRy8NE=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-434-2iIyuyj2Ot2Hm0Qm5qUVMw-1; Wed, 02 Dec 2020 20:32:16 -0500
X-MC-Unique: 2iIyuyj2Ot2Hm0Qm5qUVMw-1
Received: by mail-qk1-f197.google.com with SMTP id l7so633472qkl.16
        for <linux-kselftest@vger.kernel.org>; Wed, 02 Dec 2020 17:32:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=T+i4hgnbURlmHWFQ6sHh3xD+xz+pB56D5OvWJIuIZUg=;
        b=QwQUPLwnTRn7vdkdwr5CqCFFd7Gi6WyuNfCvnNz1etGH+FwXjfwiIVkFVaJE19eyrT
         hr45bUXSt8kygQBV3S+4S0hxB0IaE1BqD4tj/9mzKBXU0u/RBuOfwzce34WSMixLfY3J
         H/jki+q1dvuT8IOw2Yp4tbYWJdbsKv15vNojXEtdwVHkDgAH889IVi6fKCY0Qf3bcoP6
         vdIFSc178yfftWZp3K2D9LevC7Q8/WDGACI8ZEvl1sM8NnP5gT30l+XNbgURjSCxwBzW
         4IuTp7OesXNcZmdmfcieP8+Gjr7sP8L6RSxaKRIvX/dui4SiEMXTevG/zj3mh5IknDBZ
         5jkQ==
X-Gm-Message-State: AOAM533Ow3GMJZ910dz5roVIlZUAILqi2iyQOq5oUCPRpPRRS4xXTNgR
        6EBmp1ps0SiIwwNgLUsy44nBQAvX21VYhCm8Wu7lX9lnZUsH/jkQCilLsjmqtjq6vSoJ4JRpZuO
        5dpaAuszXlf8iKu9xs3yKQDnsKvGy
X-Received: by 2002:a0c:e583:: with SMTP id t3mr1117788qvm.42.1606959136166;
        Wed, 02 Dec 2020 17:32:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzTRKK1oR4TGx3jghmRwEPH0SBs2kLQ15yxtOulZgmC1hCRslHbj2urqxef0p2YRznc+YWv2w==
X-Received: by 2002:a0c:e583:: with SMTP id t3mr1117759qvm.42.1606959135831;
        Wed, 02 Dec 2020 17:32:15 -0800 (PST)
Received: from xz-x1 ([142.126.94.187])
        by smtp.gmail.com with ESMTPSA id m8sm547711qkn.41.2020.12.02.17.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 17:32:15 -0800 (PST)
Date:   Wed, 2 Dec 2020 20:32:13 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joe Perches <joe@perches.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Alan Gilbert <dgilbert@redhat.com>,
        Greg Thelen <gthelen@google.com>,
        linux-kselftest@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] userfaultfd: selftests: make __{s,u}64 format specifiers
 portable
Message-ID: <20201203013213.GE108496@xz-x1>
References: <20201202211542.1121189-1-axelrasmussen@google.com>
 <20201202230954.GB108496@xz-x1>
 <CAJHvVch2LJa57-Si2prKa-S3VUPpu3jYxW+3-+tcLMgSXkB69w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJHvVch2LJa57-Si2prKa-S3VUPpu3jYxW+3-+tcLMgSXkB69w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Dec 02, 2020 at 03:52:56PM -0800, Axel Rasmussen wrote:
> On Wed, Dec 2, 2020 at 3:10 PM Peter Xu <peterx@redhat.com> wrote:
> >
> > Hi, Axel,
> >
> > Looks mostly good to me, but a few nitpickings below.
> >
> > On Wed, Dec 02, 2020 at 01:15:42PM -0800, Axel Rasmussen wrote:
> >
> > [...]
> >
> > > +static void uffd_error(const char *message, __s64 code)
> > > +{
> > > +     fprintf(stderr, "%s: %" PRId64 "\n", message, (int64_t)code);
> > > +     exit(1);
> > > +}
> >
> > IMHO a macro that can take arbitrary parameters would be nicer, but if it
> > satisfy our need, definitely ok too.
> >
> > [...]
> >
> > > @@ -340,7 +348,8 @@ static void wp_range(int ufd, __u64 start, __u64 len, bool wp)
> > >       prms.mode = wp ? UFFDIO_WRITEPROTECT_MODE_WP : 0;
> > >
> > >       if (ioctl(ufd, UFFDIO_WRITEPROTECT, &prms)) {
> > > -             fprintf(stderr, "clear WP failed for address 0x%Lx\n", start);
> > > +             fprintf(stderr, "clear WP failed for address 0x%" PRIx64 "\n",
> > > +                     (uint64_t)start);
> > >               exit(1);
> >
> > Is it intended to not use uffd_error() here?
> 
> Yes, this is intentional. This particular case prints the value in
> hexadecimal, rather than decimal.
> 
> (Agree that uffd_error() could be made more general to cover cases
> like this. I opted for the simplest thing which covers all but two
> cases - this one, and one where we "return 1;" instead of "exit(1);" -
> but I don't feel strongly.)

Actually it's as simple as:

#define  uffd_error(...)  do {                  \
        fprintf(stderr, __VA_ARGS__);           \
        fprintf(stderr, "\n");                  \
        exit(1);                                \
    } while (0)

But it's okay, I think.

> 
> >
> > >       }
> > >  }
> >
> > [...]
> >
> > > @@ -979,26 +981,20 @@ static int __uffdio_zeropage(int ufd, unsigned long offset, bool retry)
> > >       if (ret) {
> > >               /* real retval in ufdio_zeropage.zeropage */
> > >               if (has_zeropage) {
> > > -                     if (uffdio_zeropage.zeropage == -EEXIST) {
> > > -                             fprintf(stderr, "UFFDIO_ZEROPAGE -EEXIST\n");
> > > -                             exit(1);
> > > -                     } else {
> > > -                             fprintf(stderr, "UFFDIO_ZEROPAGE error %Ld\n",
> > > -                                     uffdio_zeropage.zeropage);
> > > -                             exit(1);
> > > -                     }
> > > +                     uffd_error(uffdio_zeropage.zeropage == -EEXIST ?
> > > +                                              "UFFDIO_ZEROPAGE -EEXIST" :
> > > +                                              "UFFDIO_ZEROPAGE error",
> >
> > Nit: The indents here are a bit odd..
> 
> This is what clang-format yields. Are you thinking it would be better
> to line everything up with the ( in uffd_error( ?
> 
> Or, perhaps this case is a good reason to make uffd_error() a variadic
> macro so we can insert "-EEXIST" || "error" with a "%s".

Yes.  It fixes a build warning, so I think current patch is fine too.

No matter whether you'd like a v2, please feel free to take:

Acked-by: Peter Xu <peterx@redhat.com>

Thanks,

-- 
Peter Xu

