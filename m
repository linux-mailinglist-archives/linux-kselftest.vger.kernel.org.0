Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D119E113660
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Dec 2019 21:25:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727911AbfLDUZv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 4 Dec 2019 15:25:51 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43059 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727887AbfLDUZv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 4 Dec 2019 15:25:51 -0500
Received: by mail-lj1-f195.google.com with SMTP id a13so770714ljm.10;
        Wed, 04 Dec 2019 12:25:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q1HDbNtziDmWn+nZrAorGFLczK81PnzJXfxFuv+uGos=;
        b=isOkK7jEUsiIbE8op5mEt0BDkQUXYQSgX5LoWkkU1yYu/SjbiwRiNC1dN67TJA65YZ
         gFeLozQOWBjANrnXjwVGEQt3Jk7S0nnBIkrFAr/KK8Icnf0EvLx11Mg6pccdLVVi1dTB
         /lCb8fMVvusHsMfkVAozHtwwaIGJ/ODtWjFWlIwXKsgDo1duf95yEic776rUJZl1YPFa
         nwUzmWgRR7d+JtNL3EUP7UqnZnpJ41Q820pawJ2l08WnHbAW5ShTchPJUOz+882BmieP
         Y6mv2Kt5V7Fh3I3V9OGmiQfwRshEUSr1s745kp6JAuxB8ATVbMRBTbkohDPrV9HeiRRf
         WjvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q1HDbNtziDmWn+nZrAorGFLczK81PnzJXfxFuv+uGos=;
        b=f/7JyJYXwtktx1qWlW6J9kyiQdPtNKBALbfiqk5wdWsUVNerxhv0W5j4W1F+MhoJ92
         W/tOhs4C/7gvnN7VRLvOCP/0/XDwQ7JxneoMDLSi1KvYS4uoPRSZyRh/FuotWFRBXx1O
         zUPfXyBe+wLZa6kOzlCoYPu/f+aJdPINU4i/Vil4oTgBtwYgZ42dNT6LPiomhsrdbf0l
         W9NuoAaZ6mnD/K0QmW0ot9BUkGjCECb9W+/w+G3FbOgqxDMC9G3ExrTO4VFQMhZyRat1
         4rPFsJkT6qzJG3X2fdWCKcQf1b2h3T+H1E6o/23VNJnlwiuL3j5PHi10GlCRWsyUdsU0
         b60w==
X-Gm-Message-State: APjAAAXGoOxw7x3riUvGlFD3qMRrnJXvslPaZMEeYkj0lrc81+6rYAyF
        m6j6jR2B82dipMvnCgHsHF9y6qpR0vcXB+uIUI8=
X-Google-Smtp-Source: APXvYqyYSPA5OmBseF+oP2/0KobwdsYBxyGBDH8F5+DbyooGjfmL7VhNSK+UhPKxR+9+i4OiUYWjZl5/B5HSUHar5Og=
X-Received: by 2002:a2e:8953:: with SMTP id b19mr2947176ljk.249.1575491148522;
 Wed, 04 Dec 2019 12:25:48 -0800 (PST)
MIME-Version: 1.0
References: <1575396508-21480-1-git-send-email-sj38.park@gmail.com>
 <CAFd5g46X9WK-xKJFF5AVYXXmM4a2dYD3fy=oi1CGJM1gc9RzuA@mail.gmail.com> <20191204192141.GA247851@google.com>
In-Reply-To: <20191204192141.GA247851@google.com>
From:   SeongJae Park <sj38.park@gmail.com>
Date:   Wed, 4 Dec 2019 21:25:21 +0100
Message-ID: <CAEjAshrXG3GmNMAS6Upu0=cCe9KJxchQWeiqLg0b8kif9ivNTg@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] Fix nits in the kunit
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, shuah <shuah@kernel.org>,
        SeongJae Park <sjpark@amazon.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Dec 4, 2019 at 8:21 PM Brendan Higgins
<brendanhiggins@google.com> wrote:
>
> On Tue, Dec 03, 2019 at 02:41:26PM -0800, Brendan Higgins wrote:
> > On Tue, Dec 3, 2019 at 10:08 AM SeongJae Park <sj38.park@gmail.com> wrote:
> > >
> > > This patchset contains trivial fixes for the kunit documentations and the
> > > wrapper python scripts.
> > >
> > > Changes from v2 (https://lore.kernel.org/linux-kselftest/1575361141-6806-1-git-send-email-sj38.park@gmail.com/T/#t):
> > >  - Make 'build_dir' if not exists (missed from v3 by mistake)
> > >
> > > SeongJae Park (5):
> > >   docs/kunit/start: Use in-tree 'kunit_defconfig'
> > >   kunit: Remove duplicated defconfig creation
> > >   kunit: Create default config in '--build_dir'
> > >   kunit: Place 'test.log' under the 'build_dir'
> > >   kunit: Rename 'kunitconfig' to '.kunitconfig'
> > >
> > >  Documentation/dev-tools/kunit/start.rst | 13 +++++--------
> > >  tools/testing/kunit/kunit.py            | 16 ++++++++++------
> > >  tools/testing/kunit/kunit_kernel.py     |  8 ++++----
> > >  3 files changed, 19 insertions(+), 18 deletions(-)
> >
> > Tested-by: Brendan Higgins <brendanhiggins@google.com>
>
> I just realized that I forgot to test for something...
>
> The following command fails:
>
> ./tools/testing/kunit/kunit.py run --timeout=60 --jobs=12 --defconfig
>
> [11:17:13] Building KUnit Kernel ...
> [11:17:16] Starting KUnit Kernel ...
> Traceback (most recent call last):
>   File "tools/testing/kunit/kunit.py", line 142, in <module>
>     main(sys.argv[1:])
>   File "tools/testing/kunit/kunit.py", line 135, in main
>     result = run_tests(linux, request)
>   File "tools/testing/kunit/kunit.py", line 67, in run_tests
>     test_result = kunit_parser.parse_run_tests(kunit_output)
>   File "/usr/local/google/home/brendanhiggins/gbmc-linux/tools/testing/kunit/kunit_parser.py", line 283, in parse_run_tests
>     test_result = parse_test_result(list(isolate_kunit_output(kernel_output)))
>   File "/usr/local/google/home/brendanhiggins/gbmc-linux/tools/testing/kunit/kunit_parser.py", line 54, in isolate_kunit_output
>     for line in kernel_output:
>   File "/usr/local/google/home/brendanhiggins/gbmc-linux/tools/testing/kunit/kunit_kernel.py", line 146, in run_kernel
>     with open(os.path.join(build_dir, 'test.log'), 'w') as f:
>   File "/usr/lib/python3.7/posixpath.py", line 80, in join
>     a = os.fspath(a)
> TypeError: expected str, bytes or os.PathLike object, not NoneType
>
> It seems as though you assume that build_dir is always populated by the flag.

Sorry for not checking the case.  The 4th patch, "kunit: Place 'test.log' under
the 'build_dir'" made the bug.  I fixed the 4th patch and tested with below
commands:

    ./tools/testing/kunit/kunit.py run --timeout=60 --jobs=12
--defconfig --build_dir .kunit
    ./tools/testing/kunit/kunit.py run --timeout=60 --jobs=12 --defconfig

Just sent the 4th version patchset including the fix:
    http://lkml.kernel.org/r/1575490683-13015-1-git-send-email-sj38.park@gmail.com

I will consider adding some tests that can check such cases in the
'kunit_tools_test.py' later.


Thanks,
SeongJae Park
