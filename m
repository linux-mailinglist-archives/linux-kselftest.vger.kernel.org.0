Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 412AA1120C5
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Dec 2019 01:52:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726107AbfLDAwJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 3 Dec 2019 19:52:09 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34851 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbfLDAwJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 3 Dec 2019 19:52:09 -0500
Received: by mail-pf1-f194.google.com with SMTP id b19so2720508pfo.2
        for <linux-kselftest@vger.kernel.org>; Tue, 03 Dec 2019 16:52:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zz2tab3J6nQ9yBPoRKs9KWflXkGbvh+LfcpIKUx7+eU=;
        b=eA/3o3/uD+pnExTTez4CvnXKm6n6lh6VSDxYHsK80Q96VBmIJ0xEsLkLrR89L67VAV
         zJEy2y0QVYs4rDqdlRRKqH4BMTUL4HXNyU/8FJzZL4SCI5MGkLildXu8mZgA+DC+Mf4k
         9T8o4U3jsiUnpPypvq9RaIM6+jrXcMrnZUYVs+f6xv/ah7Z+OmEnM2AY24gY95Sebk0G
         X9/oxDCUYXUXeLk/P9oxO6d+fw9trRvdY9UCWE6qSgYQqBpdz/2pHzbsJJ4m9m57XKMG
         C4fM4VMQ8m9VNW0r+0y0MlU9glonGMA0+v+h4+tf1vb1+6lpMsW1hIhi8Gtwu0ooS4ZG
         ZcGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zz2tab3J6nQ9yBPoRKs9KWflXkGbvh+LfcpIKUx7+eU=;
        b=p6t0c6ccd6Yqz5f7I0LS7bJK/VIBi0AdzaChwgW0OxXhMJf83UTfljQiR06CBmtg0D
         Ouyu4qyzqeGFLa87+KyD00Zx/HFS9olcVfkSRe/fSexfCdD4EQ8CWL9COBE2hmYUPoaG
         njU4wgINt8f7650QLxdSBbFcW/GHmoMvE0Y900xOBJSdYAMXMcnjRoJMygH5SpQK16Yv
         Y4sevh5hQkzTxOkGWTNChfeDrS8Z1dUHl/243XOUdTIIvzoZlB+VrhzotJo6EPqANdrA
         dsFxsLAZZJBnmVvWMQ5aquKCTugNBF54c4pb9Yjx4JdXZ+U/YjfQiWp/s4uA2aDOz0ps
         wfWg==
X-Gm-Message-State: APjAAAXQdrrOPDfi4dBI6H14aozHLwyb3HGqFAkGWSp8eXvNeHGDSoEa
        dP3u84wOeB1jN/xhPQjXPdfEPgfJTS4WD4ppJpIN0w==
X-Google-Smtp-Source: APXvYqy7RxbrzrMCIFdOaEEQlIYMi2ZZECPAnZPVjJ8fyaTsU7OifUNfJi3d9YUoL7gMC+WYKGfO9/G+zZRxOHBEGc8=
X-Received: by 2002:aa7:961b:: with SMTP id q27mr796729pfg.23.1575420728406;
 Tue, 03 Dec 2019 16:52:08 -0800 (PST)
MIME-Version: 1.0
References: <1575374868-32601-1-git-send-email-alan.maguire@oracle.com>
 <1575374868-32601-4-git-send-email-alan.maguire@oracle.com>
 <CAFd5g47dRP9HvsZD3sqzzfbAthNq8gxEdh57owo3CqVHLNOf6w@mail.gmail.com>
 <20191204003851.GF86484@mit.edu> <CAFd5g46A5gyGg0g+GmLRFM1DY=ySf_85P2T7+VYqm4nD8J9wBA@mail.gmail.com>
In-Reply-To: <CAFd5g46A5gyGg0g+GmLRFM1DY=ySf_85P2T7+VYqm4nD8J9wBA@mail.gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 3 Dec 2019 16:51:57 -0800
Message-ID: <CAFd5g47095-kTHyd5cz1Uvxe+GtrU9=hP1=1ZUi23oCBAKY_Yw@mail.gmail.com>
Subject: Re: [PATCH v5 linux-kselftest-test 3/6] kunit: allow kunit tests to
 be loaded as a module
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Alan Maguire <alan.maguire@oracle.com>,
        Iurii Zaikin <yzaikin@google.com>,
        David Gow <davidgow@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        catalin.marinas@arm.com, joe.lawrence@redhat.com,
        penguin-kernel@i-love.sakura.ne.jp, urezki@gmail.com,
        andriy.shevchenko@linux.intel.com,
        Jonathan Corbet <corbet@lwn.net>, adilger.kernel@dilger.ca,
        Luis Chamberlain <mcgrof@kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Knut Omang <knut.omang@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Dec 3, 2019 at 4:42 PM Brendan Higgins
<brendanhiggins@google.com> wrote:
>
> On Tue, Dec 3, 2019 at 4:39 PM Theodore Y. Ts'o <tytso@mit.edu> wrote:
> >
> > On Tue, Dec 03, 2019 at 09:54:25AM -0800, Brendan Higgins wrote:
> > > On Tue, Dec 3, 2019 at 4:08 AM Alan Maguire <alan.maguire@oracle.com> wrote:
> > > >
> > > > As tests are added to kunit, it will become less feasible to execute
> > > > all built tests together.  By supporting modular tests we provide
> > > > a simple way to do selective execution on a running system; specifying
> > > >
> > > > CONFIG_KUNIT=y
> > > > CONFIG_KUNIT_EXAMPLE_TEST=m
> > > >
> > > > ...means we can simply "insmod example-test.ko" to run the tests.
> > > >
> > > > To achieve this we need to do the following:
> > > >
> > > > o export the required symbols in kunit
> > > > o string-stream tests utilize non-exported symbols so for now we skip
> > > >   building them when CONFIG_KUNIT_TEST=m.
> > > > o support a new way of declaring test suites.  Because a module cannot
> > > >   do multiple late_initcall()s, we provide a kunit_test_suites() macro
> > > >   to declare multiple suites within the same module at once.
> > > > o some test module names would have been too general ("test-test"
> > > >   and "example-test" for kunit tests, "inode-test" for ext4 tests);
> > > >   rename these as appropriate ("kunit-test", "kunit-example-test"
> > > >   and "ext4-inode-test" respectively).
> > > >
> > > > Co-developed-by: Knut Omang <knut.omang@oracle.com>
> > > > Signed-off-by: Knut Omang <knut.omang@oracle.com>
> > > > Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> > >
> > > Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
> >
> > Acked-by: Theodore Ts'o <tytso@mit.edu> # for ext4 bits
> >
> >
> > I do have one question, out of curiosity --- for people who aren't
> > using UML to run Kunit tests, and are either running the kunit tests
> > during boot, or when the module is loaded, is there the test framework
> > to automatically extract the test reports out of dmesg?
> >
> > I can boot a kernel with kunit tests enabled using kvm, and I see it
> > splatted intermixed with the rest of the kernel boot messages.  This
> > is how I tested the 32-bit ext4 inode test fix.  But I had to manually
> > find the test output.  Is that the expected way people are supposed to
> > be using Kunit tests w/o using UML and the python runner?
>
> For now, yes. We do not currently have a piece that extracts the test
> reports; however, we are planning on pulling that bit out of
> tools/testing/kunit/; we just haven't gotten around to it yet.

I just added a bug for this here:
https://bugzilla.kernel.org/show_bug.cgi?id=205761
