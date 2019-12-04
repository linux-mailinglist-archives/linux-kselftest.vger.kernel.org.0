Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C22611366E
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Dec 2019 21:28:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727978AbfLDU2p (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 4 Dec 2019 15:28:45 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39347 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727889AbfLDU2p (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 4 Dec 2019 15:28:45 -0500
Received: by mail-lj1-f195.google.com with SMTP id e10so802466ljj.6;
        Wed, 04 Dec 2019 12:28:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yKIotMcbTtZ0YF0R1baNTaDHjXcczPzr4JNxaUZOqXI=;
        b=TpHatxGpHFgxmntTYTnhcSlRQr/SlNyCLneNOiOnh2ZNZ/144zFRAOLwoNXL5Kb0hS
         Ayb5xw7IWf1QfodVr/5Pz/3D/FFcEhqYITBKOTWN6kfzbTTWw9rIkVNJ+tfuKWLf8+fo
         0CEVjcfbVaVhymc6g+cSG45QSsI2aIgL8Dn9b8xWkvlDZBZVcmS7Cnf5rwaK/pSFmK6K
         /Rjm/OAWENGDPDgdSWlGPPUDLo+XB+OV50RnpX2P9bhraxznSuM7pXgq2hLf3sF3U4JC
         hleJERGfWf737ApQDKYJa9PVnFXUF4FcmOee95qF9n08JW3KGXRnKpCCdDYwGQalfsnj
         oFHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yKIotMcbTtZ0YF0R1baNTaDHjXcczPzr4JNxaUZOqXI=;
        b=hYqjEtdoQC+i6/0QEcpma17BpbHWkSpxktKnaUS1ok3eGoChCC3UedWHF4kA78io5N
         A0W/Kcn8r2tQZeRfIveXM5iO2Zmy7Z8GI8VPiBx54GP/CAls8xLuM53C4XbFi5Cfxgo4
         fzGp/Wx99gZ+Gg302F85Bxj+4dNFWlOTSUqxpIJh9rHNEfWFPdGkH5oy8JVHel+z+SHs
         +SocJKHs+PcFlYVSpED8OLfg4cjel6RZBCYx1bzK9pA4sAMoH5ffks+/lC/QgaeVskIp
         KMFq/O4o7BNsNmwzh2mJFhwbvkQdXR6UvK1goRAdPkKbABqP24SkoePy5jX4tAXLdqes
         2Ivg==
X-Gm-Message-State: APjAAAV5GyOs0gWzpen4DWWC5GRBFUPZzXwFNX8muny3FdyJAdmFOg1h
        rGM4r3Z47cE9HveYswltlr5Ok0/WU0tXcMoyOjjhiA==
X-Google-Smtp-Source: APXvYqxSWkjq3rUQ3sYOM4hYRA4knRhOqK9uDJNATMmSoHjHWA6C00W2uDpGurmHugXH/RDtUrdcNs88tSyM9oQiL40=
X-Received: by 2002:a2e:580c:: with SMTP id m12mr3187002ljb.150.1575491323333;
 Wed, 04 Dec 2019 12:28:43 -0800 (PST)
MIME-Version: 1.0
References: <1575396508-21480-1-git-send-email-sj38.park@gmail.com>
 <CAFd5g46X9WK-xKJFF5AVYXXmM4a2dYD3fy=oi1CGJM1gc9RzuA@mail.gmail.com>
 <20191204192141.GA247851@google.com> <CAEjAshrXG3GmNMAS6Upu0=cCe9KJxchQWeiqLg0b8kif9ivNTg@mail.gmail.com>
In-Reply-To: <CAEjAshrXG3GmNMAS6Upu0=cCe9KJxchQWeiqLg0b8kif9ivNTg@mail.gmail.com>
From:   SeongJae Park <sj38.park@gmail.com>
Date:   Wed, 4 Dec 2019 21:28:16 +0100
Message-ID: <CAEjAshpQNVdLgtLyTu5WjxygRptZ4qomKCQaxw1YaX5ppvBcNQ@mail.gmail.com>
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

On Wed, Dec 4, 2019 at 9:25 PM SeongJae Park <sj38.park@gmail.com> wrote:
>
> On Wed, Dec 4, 2019 at 8:21 PM Brendan Higgins
> <brendanhiggins@google.com> wrote:
> >
> > On Tue, Dec 03, 2019 at 02:41:26PM -0800, Brendan Higgins wrote:
> > > On Tue, Dec 3, 2019 at 10:08 AM SeongJae Park <sj38.park@gmail.com> wrote:
> > > >
> > > > This patchset contains trivial fixes for the kunit documentations and the
> > > > wrapper python scripts.
> > > >
> > > > Changes from v2 (https://lore.kernel.org/linux-kselftest/1575361141-6806-1-git-send-email-sj38.park@gmail.com/T/#t):
> > > >  - Make 'build_dir' if not exists (missed from v3 by mistake)
> > > >
> > > > SeongJae Park (5):
> > > >   docs/kunit/start: Use in-tree 'kunit_defconfig'
> > > >   kunit: Remove duplicated defconfig creation
> > > >   kunit: Create default config in '--build_dir'
> > > >   kunit: Place 'test.log' under the 'build_dir'
> > > >   kunit: Rename 'kunitconfig' to '.kunitconfig'
> > > >
> > > >  Documentation/dev-tools/kunit/start.rst | 13 +++++--------
> > > >  tools/testing/kunit/kunit.py            | 16 ++++++++++------
> > > >  tools/testing/kunit/kunit_kernel.py     |  8 ++++----
> > > >  3 files changed, 19 insertions(+), 18 deletions(-)
> > >
> > > Tested-by: Brendan Higgins <brendanhiggins@google.com>
> >
> > I just realized that I forgot to test for something...
> >
> > The following command fails:
> >
> > ./tools/testing/kunit/kunit.py run --timeout=60 --jobs=12 --defconfig
> >
> > [11:17:13] Building KUnit Kernel ...
> > [11:17:16] Starting KUnit Kernel ...
> > Traceback (most recent call last):
> >   File "tools/testing/kunit/kunit.py", line 142, in <module>
> >     main(sys.argv[1:])
> >   File "tools/testing/kunit/kunit.py", line 135, in main
> >     result = run_tests(linux, request)
> >   File "tools/testing/kunit/kunit.py", line 67, in run_tests
> >     test_result = kunit_parser.parse_run_tests(kunit_output)
> >   File "/usr/local/google/home/brendanhiggins/gbmc-linux/tools/testing/kunit/kunit_parser.py", line 283, in parse_run_tests
> >     test_result = parse_test_result(list(isolate_kunit_output(kernel_output)))
> >   File "/usr/local/google/home/brendanhiggins/gbmc-linux/tools/testing/kunit/kunit_parser.py", line 54, in isolate_kunit_output
> >     for line in kernel_output:
> >   File "/usr/local/google/home/brendanhiggins/gbmc-linux/tools/testing/kunit/kunit_kernel.py", line 146, in run_kernel
> >     with open(os.path.join(build_dir, 'test.log'), 'w') as f:
> >   File "/usr/lib/python3.7/posixpath.py", line 80, in join
> >     a = os.fspath(a)
> > TypeError: expected str, bytes or os.PathLike object, not NoneType
> >
> > It seems as though you assume that build_dir is always populated by the flag.
>
> Sorry for not checking the case.  The 4th patch, "kunit: Place 'test.log' under
> the 'build_dir'" made the bug.  I fixed the 4th patch and tested with below
> commands:
>
>     ./tools/testing/kunit/kunit.py run --timeout=60 --jobs=12
> --defconfig --build_dir .kunit
>     ./tools/testing/kunit/kunit.py run --timeout=60 --jobs=12 --defconfig
>
> Just sent the 4th version patchset including the fix:
>     http://lkml.kernel.org/r/1575490683-13015-1-git-send-email-sj38.park@gmail.com

Also, removed the 'Reviewed-by' from the 4th patch and didn't add 'Tested-by'
to the patchset.


Thanks,
SeongJae Park

>
> I will consider adding some tests that can check such cases in the
> 'kunit_tools_test.py' later.
>
>
> Thanks,
> SeongJae Park
