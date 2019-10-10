Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49077D26A4
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Oct 2019 11:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387596AbfJJJuP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Oct 2019 05:50:15 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:33215 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387544AbfJJJuP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Oct 2019 05:50:15 -0400
Received: by mail-qk1-f196.google.com with SMTP id x134so5034135qkb.0
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Oct 2019 02:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eq21ieXGYfbio4/ONvnC5Y4VJvJvtnV+f7bJhm6JVDI=;
        b=kgP4jNYS15D8vXlgaBAEII5Kz7MnCpluuyFU9Bf5kO1PVhrBZrcyKftchjvaVC/0Wu
         CLo47T021TLkUeEYc8kgnUB3nbVusTl3wkaNBGww2zoZWdlY5rPKxVfHEitf9dzw/VXD
         Itr+JE89cgAiIjdQ9tgjb2ksfPSuj/LSEd5yJbrRM5tdm2QWsUPSE6pg6mf1r4PYDFlp
         qcV57MTt939pUHywKuBHLSiKefP2WEUy/59F07mu9TSXQpPDBV6v0d0w+LfWwIw2NvAH
         I6hsApuZO3ONSfSKcPYTnBQojNFODYR6n+L8zBLp9hRACkZ9CO9Q7J645GjhNyEuU+x+
         W2CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eq21ieXGYfbio4/ONvnC5Y4VJvJvtnV+f7bJhm6JVDI=;
        b=TDQhfkq3mUxcwswzjvD8ae+uMiyTWRYNHOB/7VPkDyyq0NZt1DCpgLhhFsSYpnOhOJ
         lI0WUX4hugdermwpqzOjO9X9lhft9h1DbrjH/d+IzHR4ooG9PVEluQX73uLO2rqRtzIV
         58U3hZYLBLrg0JzOlMnI6ziDDJHQL2DRVGpPAh4ozETtx4Oi93b62Cir7JA5c1baC6Ah
         m6tMj9x7q18CUKFSKKEXSCTBZdZXdEKAYu8QFVdN69sujspEnfYmwGzi8AUHIeUFF1iC
         9fW0IEjEEglZt8N5Ci3r6tVZJ4mXKXXqFrmwwFXcNYi9QR8JmdBtQhYCS7iWUCjCsQyg
         6qyg==
X-Gm-Message-State: APjAAAVf7zttMEMbPxQRsGNB6ydpR1108nVPBqYk9dB/rwO6tG53ArVR
        f6F9gm6wCZ3inUZZdvMocEiVbuH5/lyLyeWv9GNhXA==
X-Google-Smtp-Source: APXvYqw0uc2wmafldvOtFV4iMk/sTNu5MMjbDOtm5t43CvU5+L67HoQvsxCb7/WviGyf24Z33oQ8SouTYm1wB5OulQg=
X-Received: by 2002:a05:620a:6b6:: with SMTP id i22mr8537547qkh.256.1570701013485;
 Thu, 10 Oct 2019 02:50:13 -0700 (PDT)
MIME-Version: 1.0
References: <20191009142446.6997-1-rpalethorpe@suse.com> <CACT4Y+b0tTAQ0r_2gCVjjRh--Xwv=aLzh6MY=ciXMMrK+cAQsA@mail.gmail.com>
 <20191009145416.GA5014@rei.lan> <CACT4Y+ZL8ocQPpwR-_8+0PdF=r3AkFZKvOR==+P0y0GF67w1Vg@mail.gmail.com>
 <20191009180447.GD15291@rei.lan> <CACT4Y+ZABX2z4Lxrvokf5DHz351xTys-gJPNhFjP+Zx6Qd2zsg@mail.gmail.com>
 <20191010093011.GA2508@rei.lan>
In-Reply-To: <20191010093011.GA2508@rei.lan>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 10 Oct 2019 11:50:01 +0200
Message-ID: <CACT4Y+ZARc3gK9rweQnLr26Aa_8j9OrpAs-wfTVP2owqmXm+kQ@mail.gmail.com>
Subject: Re: [RFC PATCH] LTP Wrapper for Syzkaller reproducers
To:     Cyril Hrubis <chrubis@suse.cz>
Cc:     Richard Palethorpe <richard.palethorpe@suse.com>,
        syzkaller <syzkaller@googlegroups.com>, kernelci@groups.io,
        shuah <shuah@kernel.org>, ltp@lists.linux.it,
        George Kennedy <george.kennedy@oracle.com>,
        Cyril Hrubis <chrubis@suse.com>,
        "open list : KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        automated-testing@yoctoproject.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Oct 10, 2019 at 11:30 AM Cyril Hrubis <chrubis@suse.cz> wrote:
>
> Hi!
> > > > > Indeed, it's removed recursively by the test library.
> > > >
> > > > :popcorn:
> > > >
> > > > It took me several years to figure out how to more or less reliably
> > > > remove dirs after the fuzzer ;)
> > > > (no, unlink won't do ;))
> > >
> > > I guess that there are things such as immutable file attributes that has
> > > to be cleared and many more. Do you have piece of code somewhere that we
> > > can look into to spare us from reinventing the wheel?
> >
> > Here is what we have:
> > https://github.com/google/syzkaller/blob/c4b9981b5f5b70dc03eb3f76c618398510101a1d/executor/common_linux.h#L2358-L2461
> > Maybe it can be simplified, but that's what we ended up with after
> > some organic evolution. At least the comments may give some hints as
> > to what may go wrong.
>
> Thanks a lot!
>
> Also I see that you are using namespaces, and much more, to sandbox the
> fuzzer, I was wondering if we should do that, at least separate user and
> pid namespace sounds like a good idea to me.

I don't know how far you want to go. This sandboxing definitely helps
us to isolate processes and make tests more repeatable by avoiding
interference (I don't know if LTP, say, runs tests in parallel).
mount namespaces are useful to later drop all of test mounts at once,
this would solve a significant part of the remote_dir logic. If the
temp dir is on tmpfs in the mount namespace as well, then it will be
automatically dropped altogether with all contents.
